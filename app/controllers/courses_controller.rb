class CoursesController < ApplicationController
    before_action :find_course, only: [:show, :edit, :update, :destroy]
    def index
        @course=Course.all.order(course_name: :desc)
    end

    def show
    end

    def new
        @course = current_user.courses.build
    end

    def create
        @course = current_user.courses.build(event_params)
        if @course.save
            redirect_to @course
        else
            render 'new'
        end
    end

    def edit
    end

    def update
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

    def event_params
        params.require(:course).permit(:course_name)
    end
end
