FactoryBot.define do
    factory :user do
        name { Faker::Name.initials(number: 2) }
    end
end