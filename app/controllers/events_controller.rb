class EventsController < ApplicationController
    before_action :find_course, only: [:show,:index, :create,:new, :edit, :update, :destroy, :approve, :deny]
    before_action :find_event, only: [:show, :edit, :update, :approve, :deny]

    helper EventsHelper
    def index
        if current_user.courses.include?(@course)
            if current_user.isProf
                @event=[]
                #Using includes greatly reduces the number of queries. Let's test it to see how it holds up
                @course.users.where(:role => "Student").includes(:courses).each do |user|
                    user.courses.includes(:events).each do |course|
                        #Where not ignores events that are private and not mine
                        @event.concat(course.events.where("course_id = ? AND pending_approval=?", course.id, false).where.not("user_id != ? AND private = ?", current_user.id, true))
                    end
                end
                @event.uniq! #In case there are students taking the same classes
            else #Current user is a student
                @event=Event.where("course_id = ? AND pending_approval=?", @course.id, false).where.not("user_id != ? AND private=?", current_user.id, true)
            end

            cookies[:course_id]=@course.id
            cookies[:course_name]=@course.course_name

            respond_to do |format|
                format.html
                format.json
            end
        else ##User is trying to check courses where he is not enrolled in
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

        set_pending_approval(@event)
        set_className(@event)

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
            set_className(@event)
            @event.save
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

    def approve
        @event.pending_approval = false
        @event.save
        respond_to do |format|
            format.html {redirect_to pending_events_list_course_path(@course.id)}
            # => format.js
        end
    end

    def deny
        @event = @course.events.find(params[:id])
        @event.destroy
        respond_to do |format|
            format.html {redirect_to pending_events_list_course_path(@course.id)}
            #format.js
        end
    end

    private
    def find_course
        @course=Course.find(params[:course_id])
    end

    def find_event
        @event=Event.find(params[:id])
    end

    def event_params
        params.require(:event).permit(:title, :start_time, :end_time, :private)
    end

    #Assigns class names to events so that I can color code them in CSS
    def set_className(event)
        current_user.isProf ? event.className="prof-event" : event.className="student-event"
        event.className="private-event" if event.private
    end

    def set_pending_approval(event)
        event.pending_approval=false if current_user.isProf || event.isPrivate
    end
end
