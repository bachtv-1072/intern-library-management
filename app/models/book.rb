class Book < ApplicationRecord
  belongs_to :category

  validates :name, presence: true,
    length: {maximum: Settings.category.length}
  validates :description, presence: true,
    length: {maximum: Settings.book.description.length}
  validates :quantity, presence: true,
    numericality:
    {less_than_or_equal_to: Settings.book.quantity.length, only_integer: true}
end
