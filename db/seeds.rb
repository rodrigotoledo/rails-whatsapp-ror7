user = User.create(email: 'rodrigo@rtoledo.inf.br', password: 'aassdd', password_confirmation: 'aassdd')

users = []
10.times.each do
 users << User.create(email: Faker::Internet.email, password: 'aassdd', password_confirmation: 'aassdd')
end

20.times.each do
  users.each do |user_sender|
    Message.create(user: user_sender, author: user, message: Faker::Lorem.paragraph)
    Message.create(user: user, author: user_sender, message: Faker::Lorem.paragraph)
  end
end