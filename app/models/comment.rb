class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content book_id).freeze

  belongs_to :book
  belongs_to :user

  validates :content, presence: true,
    length: {maximum: Settings.book.description.length}
end
