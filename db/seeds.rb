User.transaction do |tx|
  event = Event.new
  ultra_secure_password = "qweqweqwe"

  creator = User.new(
    email: "johnny@cash.com",
    name: "Johnny Cash"
  )
  creator.password = creator.password_confirmation = ultra_secure_password
  creator.save!

  participant = User.new(
    email: "johnny@begood.com", # go go!
    name: "Johnny Begood"
  )
  participant.password = participant.password_confirmation = ultra_secure_password
  participant.save!

  activity = event.new_activity(creator,
    name: "Party!",
    start_time: 1.day.from_now.to_time,
    end_time: 1.day.from_now.to_time + 4.hours,
    location: "Pool",
    limit_of_participants: 2
  )
  activity.save!
  activity.new_participation(participant).save!
end
