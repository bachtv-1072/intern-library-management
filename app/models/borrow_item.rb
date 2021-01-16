class BorrowItem < ApplicationRecord
  BORROWITEM_PARAMS = [:book_id].freeze

  belongs_to :book
  belongs_to :borrowing, optional: true

  after_save :update_quantity_book

  delegate :name, to: :book, prefix: true, allow_nil: true

  private

  def update_quantity_book
    book.update_attribute(:quantity_borrowed, book.quantity_borrowed -
      Settings.number)
  end
end
