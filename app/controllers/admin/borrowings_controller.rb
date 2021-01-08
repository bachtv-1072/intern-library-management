class Admin::BorrowingsController < Admin::BaseController
  def update
    @borrowing = current_user.borrowings.find params[:id]
    @borrowing.pending? ? @borrowing.accept! : @borrowing.payed!
    respond_to :js
  end
end
