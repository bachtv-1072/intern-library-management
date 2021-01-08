class Admin::BorrowingsController < Admin::BaseController
  def pending
    @list_append_borrowings = Borrowing.pending
  end

  def paying
    @list_paying = Borrowing.accept
  end

  def update
    @borrowing = current_user.borrowings.find params[:id]
    @borrowing.pending? ? @borrowing.accept! : @borrowing.payed!

    respond_to :js
  end
end
