class BorrowItemsController < ApplicationController
  before_action :require_login, only: :create
  def index
    @book_borrow = Book.get_book_id_borrow_item session[:borrow_item]
    @args = (logged_in?)? current_user.borrowings.build : Borrowing.new
    @args.book_ids = session[:borrow_item]
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

end
