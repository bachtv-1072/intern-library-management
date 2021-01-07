class Image < ApplicationRecord
  IMAGE_PARAMS = %i(link _destroy).freeze

  mount_uploader :link, PictureUploader
  validates :link, presence: true
end
