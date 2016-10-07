module EventsHelper
    def count_pending_events course
        course.events.pending.count
    end
end
