class BorrowItem < ApplicationRecord
  BORROWITEM_PARAMS = [:book_id].freeze

  belongs_to :book
  belongs_to :borrowing, optional: true

  after_save :update_quantity_book

  private

  def update_quantity_book
    book.update_attribute(:quantity_borrowed, book.quantity_borrowed -
      Settings.number)
  end
end
