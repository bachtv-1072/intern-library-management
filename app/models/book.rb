class Book < ApplicationRecord
  BOOK_PARAMS = [:name,
    :description,
    :quantity,
    :category_id,
    :publisher_id,
    :author_id,
    images_attributes: Image::IMAGE_PARAMS].freeze

  acts_as_paranoid

  belongs_to :category, optional: true
  belongs_to :publisher, optional: true
  belongs_to :authors, optional: true
  has_many :book_details, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :borrow_items, dependent: :destroy
  has_many :borrowings, through: :borrow_items
  has_many :comments, dependent: :destroy
  has_many :ratings, dependent: :destroy

  accepts_nested_attributes_for :images, reject_if: :all_blank,
    allow_destroy: true

  validates :name, presence: true,
    length: {maximum: Settings.category.length}
  validates :description, presence: true,
    length: {maximum: Settings.book.description.length}
  validates :quantity, presence: true,
    numericality:
    {less_than_or_equal_to: Settings.book.quantity.length, only_integer: true}
  validates :quantity_borrowed, numericality: {only_integer: true},
    allow_nil: true

  delegate :title, to: :category, prefix: true, allow_nil: true

  scope :by_ids, ->(ids){where id: ids}
  scope :search_by_name, (lambda do |name|
    where "name LIKE ?", "%#{name}%" if name.present?
  end)
  scope :filter_by_publisher, (lambda do |publisher_id|
    where publisher_id: publisher_id if publisher_id.present?
  end)
end
