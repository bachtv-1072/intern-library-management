FactoryBot.define do
  factory :user do
    email {Faker::Internet.unique.email}
    name {Faker::Name.name}
    password {"123456"}
    role {Faker::Number.between from: 0, to: 1}
  end
end
