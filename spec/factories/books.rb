FactoryBot.define do
  factory :book do
    name {Faker::Book.title}
    description {"Sach hay"}
    quantity {Faker::Number.between from: 10, to: 20}
  end
end
