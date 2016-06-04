class EventsController < ApplicationController
    before_action :find_course, only: [:show,:index, :create,:new, :edit, :update, :destroy]
    before_action :find_event, only: [:show, :edit, :update]
    def index
        if current_user.courses.include?(@course)
            if current_user.role=="Professor"
                events=[]
                @course.users.where(:role => "Student").each do |u|
                    u.courses.each do |c|
                        events.concat(Event.where(:course_id => c.id))
                    end
                end
                @event=events.uniq! #In case there are students taking the same classes
            else #Current user is a student
                @event=Event.where(:course_id => @course.id)
            end

            respond_to do |format|
                format.html
                format.json
            end
        else ##User is trying to do some fishy stuff so let's redirect him back
            redirect_to courses_path
        end
    end

    def show
    end

    def new
        @event=Event.new
        respond_to do |format|
            format.js
        end
    end

    def create
        @event = @course.events.create(event_params)
        @event.user_id=current_user.id if current_user
        current_user.role=="Professor" ? @event.className="prof-event" : @event.className="student-event"
        @event.save
        respond_to do |format|
            if @event.save
                format.json { head :no_content }
                format.js
            else
                format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
            end
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
        params.require(:event).permit(:title, :start_time, :end_time)
    end
end
