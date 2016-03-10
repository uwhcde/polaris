json.rsvp do
  json.rsvp @event.reputation_for(:rsvp)
  json.post_id @event.id
end
