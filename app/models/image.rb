class Image < ApplicationRecord
  IMAGE_PARAMS = %i(id link book_id _destroy]).freeze

  mount_uploader :link, PictureUploader
  validates :link, presence: true
end
