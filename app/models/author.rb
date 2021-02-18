class Author < ApplicationRecord
  AUTHOR_PARAMS = %i(name story birth).freeze

  has_many :books, dependent: :destroy
  validates :name, presence: true,
    length: {maximum: Settings.author.length.name}
  validates :story, presence: true,
    length: {maximum: Settings.author.length.story}
  validates :birth, presence: true, length:
    {maximum: Settings.author.length.birth}
end
