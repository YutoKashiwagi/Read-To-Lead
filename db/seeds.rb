# frozen_string_literal: true

# ユーザー
User.create!(name: 'sample',
             email: 'sample@example.com',
             password: 'sample',
             password_confirmation: 'sample',
             profile: 'profile'
             )

99.times do |n|
  name     = Faker::Name.name
  email    = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  profile  = 'My Profile'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               profile: profile
               )
end

# 投稿
30.times do
  user = User.first
  Post.create!(user_id: user.id,
               picture: open('app/assets/images/books.jpg'),
               title:   'title'
               )
end

# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
