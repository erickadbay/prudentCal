class Event < ActiveRecord::Base
    belongs_to :course
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    APPROVED = "Approved"
    DENIED = "Denied"
    PENDING = "Pending approval"

    validates :title, presence: true

    scope :approved, -> { where(status: APPROVED) }
    scope :not_my_private, -> (user) { where.not("user_id != ? AND private = ?", user.id, true) }
    scope :pending, -> { where(pending_decision: true) }

    def as_json(options = {})
        {
          :id => self.id,
          :title => self.title,
          :start => start_time.rfc822,
          :end => end_time.rfc822,
          :className => self.className,
          :url => Rails.application.routes.url_helpers.event_path(id)
        }
    end

    def self.format_date(date_time)
        Time.at(date_time.to_i).to_formatted_s(:db)
    end

    def self.inCourses(courses)
        courses.is_a?(Array) ? where(course_id: courses.flatten.uniq!) : where(course_id: courses)
    end

    def isPrivate?
        self.private == true
    end

    def approve
        self.pending_decision = false
        self.status=APPROVED
    end

    def deny
        self.pending_decision = false
        self.status=DENIED
    end

    #Assigns class names to events so that I can color code them in CSS
    def set_className(user)
        user.isProf? ? self.className="prof-event" : self.className="student-event"
        self.className="private-event" if self.isPrivate?
    end

    def decorate(user)
        if user.isProf? || self.isPrivate?
            self.status = APPROVED
            self.pending_decision=false
        else
            self.status = PENDING
        end
        self.set_className(user)
    end
end
