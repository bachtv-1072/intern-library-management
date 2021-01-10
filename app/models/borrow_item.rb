class BorrowItem < ApplicationRecord
  belongs_to :book
  belongs_to :borrowing

  validates :borrowing_id, presence: true

  after_save :default_quantity_borrowed

  private

  def after_create_borrowing
    self.quantity_borrowed += 1
  end

  def default_quantity_borrowed
    self.quantity_borrowed = 0
  end
end
