json.array!(@event) do |event|
    json.extract! event, :id, :title, :user_id
    #json.event_date event.event_date
    json.start event.start_time
    json.end event.end_time
    json.url course_event_path(event.course_id, event)
end
