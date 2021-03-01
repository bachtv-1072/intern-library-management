class BorrowingsController < ApplicationController
  load_and_authorize_resource

  before_action :require_login, only: :create

  def index
    @borrowings = current_user.borrowings
                              .accessible_by(current_ability)
                              .order_borrowing
                              .page(params[:page])
                              .per Settings.panigate.category
  end

  def create
    @borrowing = current_user.borrowings.build borrowing_params
    return unless @borrowing.save

    session[:borrow_item] = nil
    flash[:success] = t "borrow_items.create.message"
    redirect_to root_path
  end

  private

  def borrowing_params
    params.require(:borrowing).permit Borrowing::BORROWING_PARAMS
  end
end
