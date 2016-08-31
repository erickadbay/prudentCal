module EventsHelper
    def get_pending_events(id)
        return Event.where("course_id = ? AND pending_decision = ?", id, true)
    end

    def count_pending_events(id)
        return get_pending_events(id).count
    end
end
