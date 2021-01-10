class Category < ApplicationRecord
  CATEGORY_PARAMS = %i(title avatar).freeze

  has_many :books, dependent: :destroy
  has_one_attached :avatar

  validates :title, presence: true,
    length: {maximum: Settings.category.length}
 
  scope :order_by, -> { order(title: :asc) }
  scope :filter_by_title, (lambda do |title|
    where "title LIKE ?", "%#{title}%" if title.present?
  end)
end