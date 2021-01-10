class BorrowItem < ApplicationRecord
  belongs_to :book
  belongs_to :borrowing, inverse_of: :borrow_items

  after_save :default_quantity_borrowed

  private

  def after_create_borrowing
    self.quantity_borrowed += 1
  end

  def default_quantity_borrowed
    self.quantity_borrowed = 0
  end
end
