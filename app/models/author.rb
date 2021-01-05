class Author < ApplicationRecord
  AUTHOR_PARAMS = %i(name story birth).freeze

  validates :name, presence: true,
    length: {maximum: Settings.author.length.name}
  validates :story, presence: true,
    length: {maximum: Settings.author.length.story}
  validates :birth, presence: true,
    length: {maximum: Settings.author.length.birth}
end
