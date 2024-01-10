FactoryBot.define do
    factory :post do
        admin_id { '1' }
        title { Faker::Lorem.sentence(word_count: 2) }
        content { '投稿内容投稿内容投稿内容投稿内容投稿内容' }
    end
end