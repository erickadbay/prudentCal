class CoursesController < ApplicationController
    before_action :find_course, only: [:show, :edit, :update, :destroy]
    def index
        @course=current_user.courses
    end

    def show
        redirect_to course_events_path(@course.id)
    end

    def new
        @course = current_user.courses.build
    end

    def create
        @course = Course.new(course_params)
        @users=User.where(:id=>params[:students])
        @course.user_id=current_user.id if current_user
        @course.users << @users
        if @course.save
            redirect_to @course
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        @users=User.where(:id=>params[:students])
        @course.users << @users
        if @course.update(course_params)
            redirect_to @course
        else
            render 'edit'
        end
    end

    def destroy
        @course.destroy
        redirect_to courses_path
    end

    private
    def find_course
        @course=Course.includes(:events).find(params[:id])
    end

    def course_params
        params.require(:course).permit(:course_name)
    end
end
