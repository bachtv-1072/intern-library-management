class Borrowing < ApplicationRecord
  BORROWING_PARAMS = [borrow_items_attributes: BorrowItem::BORROWITEM_PARAMS].freeze

  has_many :borrow_items, dependent: :destroy
  has_many :books, through: :borrow_items
  belongs_to :user, optional: true

  accepts_nested_attributes_for :borrow_items

  enum status: {pending: 0 , accept: 1, cancel: 2}

  class << self
    def generate_borrow_code
      code = [*('A'..'Z')].sample(10).join

      while Borrowing.find_by(borrow_code: code)
        code = [*('A'..'Z')].sample(10).join
      end
      code
    end
  end
end
