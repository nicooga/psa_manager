def freeze_time
  date = Time.now
  Time.stub now: date
  date
end
