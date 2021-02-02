class BorrowItem < ApplicationRecord
  BORROWITEM_PARAMS = [:book_id].freeze

  acts_as_paranoid

  belongs_to :book
  belongs_to :borrowing, optional: true

  validates :book_id, presence: true

  after_save :update_quantity_book

  delegate :name, to: :book, prefix: true, allow_nil: true

  private

  def update_quantity_book
    book.update_attribute(:quantity_borrowed, book.quantity_borrowed -
      Settings.number)
  end
end
