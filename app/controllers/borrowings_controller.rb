class BorrowingsController < ApplicationController
  before_action :require_login, only: :create

  def index
    @borrow_items = current_borrowing.borrow_items
  end
  def create
    @borrowing = current_user.borrowings.build borrowing_params
    @borrowing.borrow_code = Borrowing.generate_borrow_code
    @borrowing.save
    session[:borrow_item] = nil
    flash[:success] = t "borrow_items.create.message"
    redirect_to root_path
  end

  private

  def borrowing_params
    params.require(:borrowing).permit Borrowing::BORROWING_PARAMS
  end
end
