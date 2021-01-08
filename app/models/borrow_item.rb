class BorrowItem < ApplicationRecord
  BORROWITEM_PARAMS = [:book_id].freeze

  belongs_to :book
  belongs_to :borrowing, optional: true
end
