class Borrowing < ApplicationRecord
  BORROWING_PARAMS = [borrow_items_attributes:
    BorrowItem::BORROWITEM_PARAMS].freeze

  acts_as_paranoid

  has_many :borrow_items, dependent: :destroy
  has_many :books, through: :borrow_items
  belongs_to :user, optional: true

  accepts_nested_attributes_for :borrow_items

  delegate :name, :email, to: :user, prefix: true, allow_nil: true

  enum status: {pending: 0, accept: 1, cancel: 2, payed: 3}

  before_create :save_borrow_code
  after_update :return_quantity

  scope :order_borrowing, ->{order(:status)}

  ransacker :created_at do
    Arel.sql("date(created_at)")
  end

  def return_quantity
    return unless payed?

    return_book
  end

  def accept_borrowing
    update(
      date_borrow: updated_at,
      date_pay: updated_at + Settings.date.day
    )
  end

  def borrowing_cancel
    return_book
  end

  class << self
    def ransackable_attributes auth_object = nil
      if auth_object == :admin
        super
      else
        %w(borrow_code date_borrow date_pay status)
      end
    end
  end

  private

  def return_book
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
