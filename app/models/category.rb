class Category < ApplicationRecord
  CATEGORY_PARAMS = %i(title avatar).freeze

  has_many :books, dependent: :destroy
  has_one_attached :avatar

  validates :title, presence: true,
    length: {maximum: Settings.category.length}
end
