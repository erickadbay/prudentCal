json.array!(@event) do |event|
    json.extract! event, :id, :title, :user_id
    json.start event.start_time
    json.end event.end_time
    json.className event.className
    json.url course_event_path(event.course_id, event)
end
