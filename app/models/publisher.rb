class Publisher < ApplicationRecord
  PUBLISHER_PARAMS = [:name].freeze

  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: Settings.category.length}
end
