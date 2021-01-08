class BorrowingsController < ApplicationController
  def create
    @borrowing = current_user.borrowings.build borrowing_params
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
