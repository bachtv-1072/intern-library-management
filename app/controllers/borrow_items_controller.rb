class BorrowItemsController < ApplicationController
  before_action :require_login, only: :create

  def index
    @book_borrow = Book.get_book_id_borrow_item session[:borrow_item]
    @current_borrow = BorrowItem.new
    @borrowing = @current_borrow.build_borrowing
  end

  def create
    session[:borrow_item].each do |book_id|
      @current_borrow = BorrowItem.create book_id: book_id
    end
    session[:borrow_item] = nil
    flash[:success] = t "borrow_items.create.message"
    redirect_to root_path
  end

  def insert_book_to_session
    session[:borrow_item] ||= []
    @status =
      if session[:borrow_item].include? params[:borrow_item][:book_id].to_i
        Settings.borrow.exist
      else
        session[:borrow_item].push params[:borrow_item][:book_id].to_i
      end
    respond_to :js
  end

  def destroy; end

  private

  def borrow_item_params
    params.require(:borrow_item).permit BorrowItem::BORROWITEM_PARAMS
  end
end
