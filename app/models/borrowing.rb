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
  scope :by_borrow_code, (lambda do |borrow_code|
    where "borrow_code LIKE ?", "%#{borrow_code}%" if borrow_code.present?
  end)
  scope :by_date_start, (lambda do |date_start|
    where "date_pay = ?", date_pay if date_pay.present?
  end)
  scope :by_user, (lambda do |user_id|
    where(user_id: user_id) if user_id.present?
  end)

  def return_quantity
    return unless payed? || cancel?

    return_book
  end

  def accept_borrowing
    update(
      date_borrow: updated_at,
      date_pay: updated_at + Settings.date.day
    )
    BorrowingMailer.new_borrowing(self).deliver_later
  end

  def borrowing_cancel
    BorrowingMailer.cancel_borrowing(self).deliver_later
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
