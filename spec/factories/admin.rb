FactoryBot.define do
    factory :admin do
        email { Faker::Internet.email }
        password { 'Password123' }
        password_confirmation { 'Password123' }
    end
end