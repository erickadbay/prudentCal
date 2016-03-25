json.array!(@event) do |event|
    json.extract! event, :id, :title, :event_date
    json.start event.start_time
    json.end event.end_time
    #json.url event_url(event)
end
