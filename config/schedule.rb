every :day, :at => '0:00' do
  runner "Topic.vote_user"
end
