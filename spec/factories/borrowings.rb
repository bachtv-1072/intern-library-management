FactoryBot.define do
  factory :borrowing do
    status {Settings.status.pending}
  end
end
