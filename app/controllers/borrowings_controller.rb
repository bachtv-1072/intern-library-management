class BorrowingsController < ApplicationController
  def index
    @borrowing = current_borrowing.borrow_items
  end
end
