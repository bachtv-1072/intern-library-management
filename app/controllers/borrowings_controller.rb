class BorrowingsController < ApplicationController
  def index
    @borrow_items = current_borrowing.borrow_items
  end
end
