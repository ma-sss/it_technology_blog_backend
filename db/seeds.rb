# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
count = 0

1.times do |i|
  admin = Admin.create!(email: "admin#{i}@example.com", password: "Password123", password_confirmation: "Password123")

    3.times do |j|
        post = Post.create!(admin_id: admin.id, title: "仮の投稿タイトル#{j}", content: "仮の投稿内容#{j}")

        2.times do |k|
            Comment.create!(post_id: post.id, admin_id: admin.id, user_id: nil, text: "投稿内容いいね！")

            2.times do |l|
                comment = Comment.last
                Reply.create!(comment_id: comment.id, admin_id: admin.id, user_id: nil, text: "コメント内容いいね！")

                count += 1
                user = User.create!(name: "一般ユーザー#{count}")
                Reply.create!(comment_id: comment.id, admin_id: nil, user_id: user.id, text: "コメント内容いいね！")
            end

            count += 1
            user = User.create!(name: "一般ユーザー#{count}")
            Comment.create!(post_id: post.id, admin_id: nil, user_id: user.id, text: "投稿内容いいね！")

            2.times do |m|
                comment = Comment.last
                Reply.create!(comment_id: comment.id, admin_id: admin.id, user_id: nil, text: "コメント内容いいね！")

                count += 1
                user = User.create!(name: "一般ユーザー#{count}")
                Reply.create!(comment_id: comment.id, admin_id: nil, user_id: user.id, text: "コメント内容いいね！")
            end
        end
    end
end