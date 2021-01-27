FactoryBot.define do
  factory :author do
    name {Faker::Book.author}
    story {Faker::Books::Dune.quote}
    birth {Faker::Time.between(from: "1900-02-01", to: "1990-02-01", format: :short)}
  end
end
