class Borrowing < ApplicationRecord
  BORROWING_PARAMS = [borrow_items_attributes:
    BorrowItem::BORROWITEM_PARAMS].freeze

  has_many :borrow_items, dependent: :destroy
  has_many :books, through: :borrow_items
  belongs_to :user, optional: true

  accepts_nested_attributes_for :borrow_items

  delegate :name, to: :user, prefix: true, allow_nil: true
  delegate :email, to: :user, prefix: true, allow_nil: true

  enum status: {pending: 0, accept: 1, cancel: 2, payed: 3}

  before_save :save_borrow_code
  after_update :return_quantity

  private

  def return_quantity
    return unless payed?

    borrow_items.each do |borrow_item|
      borrow_item.book.update_attribute(
        :quantity_borrowed,
        borrow_item.book.quantity_borrowed + Settings.number
      )
    end
  end

  def generate_borrow_code
    code = [*("A".."Z")].sample(Settings.random).join
    while Borrowing.find_by borrow_code: code
      code = [*("A".."Z")].sample(Settings.random).join
    end
    code
  end

  def save_borrow_code
    self.borrow_code = generate_borrow_code
  end
end
