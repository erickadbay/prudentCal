class EventsController < ApplicationController
    before_action :find_course, only: [:show,:index, :create,:new, :edit, :update, :destroy]
    before_action :find_event, only: [:show, :edit, :update]
    def index
        #@event=Event.where(:course_id => @course.id).order(event_date: :asc)
        #@courses=current_user.courses
        events=Array.new
        if current_user.role=="Professor"
            @course.users.each do |u|
                u.courses.each do |c|
                    c.events.each do |e|
                        events<<e
                    end
                end
            end
            
            @event=events.uniq
        else
            @event=Event.where(:course_id => @course.id).order(event_date: :asc)
        end
    end

    def show
    end

    def new
        @event=Event.new
    end

    def create
        @event = @course.events.create(params[:event].permit(:title, :event_date, :start_time, :end_time))
        @event.user_id=current_user.id if current_user
        @event.save

        if @event.save
            redirect_to course_events_path
        else
            render 'new'
        end
    end

    def edit
    end

    def update
        if @event.update(event_params)
            redirect_to course_event_path(@course.id, @event.id)
        else
            render 'edit'
        end
    end

    def destroy
        @event = @course.events.find(params[:id])
        @event.destroy
        redirect_to course_events_path(@course.id)
    end

    private
    def find_course
        @course=Course.find(params[:course_id])
    end

    def find_event
        @event=Event.find(params[:id])
    end

    def event_params
        params.require(:event).permit(:title, :event_date, :start_time, :end_time)
    end
end
