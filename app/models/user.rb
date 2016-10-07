class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable
    has_and_belongs_to_many :courses
    has_many :events

    scope :students, -> { where(:role => "Student") }
    
    def isProf?
        self.role=="Professor"
    end
end
