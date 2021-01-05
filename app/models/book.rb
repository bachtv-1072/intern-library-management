class Book < ApplicationRecord
  CATEGORY_PARAMS = [:name,
    :description,
    :quantity,
    :category_id,
    :publisher_id,
    images_attributes: Image::IMAGE_PARAMS].freeze

  belongs_to :category
  belongs_to :publisher
  has_many :authors, through: :book_details
  has_many :book_details, dependent: :destroy
  has_many :images, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: :all_blank,
    allow_destroy: true

  validates :name, presence: true,
    length: {maximum: Settings.category.length}
  validates :description, presence: true,
    length: {maximum: Settings.book.description.length}
  validates :quantity, presence: true,
    numericality:
    {less_than_or_equal_to: Settings.book.quantity.length, only_integer: true}
end
