class Course < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_many :events, dependent: :destroy

    validates :course_name, presence: true
end
