class CoursesController < ApplicationController
    before_action :authenticate_user!
    before_action :find_course, only: [:show, :edit, :update, :destroy]
    before_action :get_courses, only: [:index, :new]

    def index
    end

    def show
        redirect_to course_events_path(@course.id)
    end

    def new
        @course = @courses.build
    end

    def create
        @course = Course.new(course_params)
        @users=User.where(:id => params[:students])
        @course.user_id=current_user.id if current_user
        @course.users << @users
        if @course.save
            redirect_to course_events_path(@course)
        else
            render 'new'
        end
    end

    private
    def find_course
        @course=Course.find(params[:id])
    end

    def course_params
        params.require(:course).permit(:course_name)
    end

    def get_courses
        @courses = current_user.courses
    end
end
