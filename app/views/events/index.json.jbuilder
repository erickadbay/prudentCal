json.array!(@event) do |event|
    json.extract! event, :id, :title
    json.event_date event.event_date
    json.start event.start_time
    json.end event.end_time
end
