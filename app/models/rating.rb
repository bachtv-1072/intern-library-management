class Rating < ApplicationRecord
  RATING_PARAMS = %i(point book_id).freeze

  belongs_to :book
  belongs_to :user
end
