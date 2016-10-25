class AddIndexesToCoursesUsers < ActiveRecord::Migration
  def change
      add_index :courses_users, :course_id
      add_index :courses_users, :user_id
  end
end
