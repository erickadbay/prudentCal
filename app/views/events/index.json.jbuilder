json.array!(@event) do |event|
    json.extract! event, :id, :title
    json.start event.start_time
    json.end event.end_time
    json.url course_event_path(event.course_id, event)
end
