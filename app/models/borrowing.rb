class Borrowing < ApplicationRecord
  has_many :borrow_items, inverse_of: :borrowing
  has_many :books, through: :borrow_items

  belongs_to :user, foreign_key: true

  enum status: {pendding: 0, approved: 1, cancel: 2}

  before_save :default_status
  before_save :set_date_for_borrow_date

  private

  def default_status
    self.status = 0
  end

  def set_date_for_borrow_date
    self.date_borrow = Time.now.to_datetime
  end

end
