class BorrowItemsController < ApplicationController
  before_action :action_for_form, only: %i(index destroy)

  def index
    @book_borrows = Book.by_ids(session[:borrow_item]).page(params[:page]).per(
      Settings.panigate.category
    )
    @args.book_ids = session[:borrow_item]
  end

  def create
    session[:borrow_item] ||= []
    @status =
      if session[:borrow_item].include? params[:borrow_item][:book_id].to_i
        Settings.borrow.exist
      else
        session[:borrow_item].push params[:borrow_item][:book_id].to_i
      end
    respond_to :js
  end

  def destroy
    @delete =
      if session[:borrow_item].include? params[:id].to_i
        session[:borrow_item].delete params[:id].to_i
      else
        Settings.borrow.exist
      end
    respond_to :js
  end

  private

  def action_for_form
    @args = logged_in? ? current_user.borrowings.build : Borrowing.new
  end

  def borrow_item_params
    params.require(:borrow_item).permit BorrowItem::BORROWITEM_PARAMS
  end
end
