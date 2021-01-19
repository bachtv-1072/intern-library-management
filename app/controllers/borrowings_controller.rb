class BorrowingsController < ApplicationController
  before_action :require_login, only: :create

  def create
    @borrowing = current_user.borrowings.build borrowing_params
    return unless @borrowing.save

    BorrowingMailer.with(borrowing: @borrowing).new_borrowing.deliver_later
    session[:borrow_item] = nil
    flash[:success] = t "borrow_items.create.message"
    redirect_to root_path
  end

  private

  def borrowing_params
    params.require(:borrowing).permit Borrowing::BORROWING_PARAMS
  end
end
