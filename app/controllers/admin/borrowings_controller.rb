class Admin::BorrowingsController < Admin::BaseController
  before_action :find_borrowing, only: %i(update destroy)

  def index
    @search = Borrowing.ransack params[:q], auth_object: set_ransack_auth_object
    @borrowings_result = @search.result.order_borrowing.page(params[:page]).per(
      Settings.panigate.borrowing
    )
  end

  def update
    if @borrowing.pending?
      @borrowing.accept_borrowing
      @borrowing.accept!
      SendEmailAcceptBorrowingJob.set(wait: 2.minutes).perform_later @borrowing
    else
      @borrowing.payed!
    end
    respond_to :js
  end

  def destroy
    @success = @borrowing.cancel!
    @borrowing.borrowing_cancel
    SendEmailAcceptBorrowingJob.perform_later @borrowing
    respond_to :js
  end

  private

  def find_borrowing
    @borrowing = Borrowing.find params[:id]
  end
end
