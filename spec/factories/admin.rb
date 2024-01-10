FactoryBot.define do
    factory :admin do
        name { '鈴木一郎' }
        email { Faker::Internet.email }
        password { 'Password123' }
        password_confirmation { 'Password123' }
    end
end