module EventsHelper
    def count_pending_events course
        course.events.pending.length
    end
end
