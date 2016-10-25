class EventsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_course
    before_action :find_event, only: [:show, :edit, :update, :approve, :deny, :pending_event]

    def index
        if @course && current_user.courses.include?(@course)
            if current_user.isProf?
                courses=[]
                #Eager loading greatly reduces the number of queries.
                @course.users.students.includes(:courses).each{ |u| courses<<u.courses.map(&:id) }
                @event = Event.inCourses(courses)
            else #Current user is a student
                @event = @course.events
            end
            #In case there are students taking the same classes, we only want unique events.
            @event=@event.approved.not_my_private(current_user).uniq!

            cookies[:course_id]=@course.id
            cookies[:course_name]=@course.course_name

            respond_to do |format|
                format.html
                format.json
            end
        else ##User is trying to check courses where he is not enrolled in or check a course that doesnt exist
            render 'notfound'
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
        @event.decorate(current_user)
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
        @event.set_className(current_user)
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

    def approve
        @event.approve
        respond_to do |format|
            if @event.save
                format.html { redirect_to course_pending_events_path(@course.id) }
                format.js
            else
                format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def deny
        @event.deny
        respond_to do |format|
            if @event.save
                format.html { redirect_to course_pending_events_path(@course.id) }
                format.js
            else
                format.json { render json: @event.errors.full_messages, status: :unprocessable_entity }
            end
        end
    end

    def pending_events
        @pending_events_list = current_user.isProf? ? @course.events.pending : current_user.events.inCourses(@course.id).paginate(page: params[:page], per_page: 5)
    end

    def pending_event
        render 'show'
    end

    private
    def find_course
        begin
            @course=Course.find(params[:course_id])
        rescue ActiveRecord::RecordNotFound
            @course = nil
        end
    end

    def find_event
        @event=Event.find(params[:id])
    end

    def event_params
        params.require(:event).permit(:title, :start_time, :end_time, :private)
    end
end
