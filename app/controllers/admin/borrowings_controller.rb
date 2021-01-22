class Admin::BorrowingsController < Admin::BaseController
  before_action :find_borrowing, only: %i(update destroy)

  def update
    if @borrowing.pending?
      @borrowing.accept_borrowing
      @borrowing.accept!
    else
      @borrowing.payed!
    end
    respond_to :js
  end

  def destroy
    @success = @borrowing.cancel!
    @borrowing.borrowing_cancel
    respond_to :js
  end

  private

  def find_borrowing
    @borrowing = Borrowing.find params[:id]
  end
end
