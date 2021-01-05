class Publisher < ApplicationRecord
  PUBLISHER_PARAMS = %i(name).freeze

  has_many :books, dependent: :destroy

  validates :name, presence: true,
    length: {maximum: 100}
end
