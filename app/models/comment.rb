class Comment < ApplicationRecord
  COMMENT_PARAMS = %i(content book_id).freeze

  belongs_to :book
  belongs_to :user
end
