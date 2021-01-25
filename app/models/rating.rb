class Rating < ApplicationRecord
  RATING_PARAMS = %i(point book_id).freeze

  belongs_to :user
  belongs_to :book

  validates :point, presence: true,
    numericality:
    {less_than_or_equal_to: Settings.point, only_integer: true}
end
