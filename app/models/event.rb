class Event < ActiveRecord::Base
    belongs_to :course
    belongs_to :user

    $approved = "Approved"
    $denied = "Denied"
    $pending = "Pending approval"

    validates :title, presence: true

    scope :in_courses, -> (courses) { where(course_id: courses.flatten.uniq!) }
    scope :in_course, -> (course_id) { where(course_id: course_id) }
    scope :approved, -> { where(status: $approved) }
    scope :not_my_private, -> (user) { where.not("user_id != ? AND private = ?", user.id, true) }
    scope :pending, -> { where(pending_decision: true) }
    scope :my_public, -> (user) { where("user_id = ? AND private = ?", user.id, false) }

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

    def isPrivate?
        self.private == true
    end

    def approve
        self.pending_decision = false
        self.status=$approved
    end

    def deny
        self.pending_decision = false
        self.status=$denied
    end

    def set_event_status(user)
        self.status = user.isProf? || self.isPrivate? ? $approved : $pending
    end

    def set_pending_decision(user)
        self.pending_decision=false if user.isProf? || self.isPrivate?
    end

    #Assigns class names to events so that I can color code them in CSS
    def set_className(user)
        user.isProf? ? self.className="prof-event" : self.className="student-event"
        self.className="private-event" if self.isPrivate?
    end
end
