class BorrowItemsController < ApplicationController
  before_action :authentication
  before_action :get_current_borrowing
  def show; end

  def create
    @borrow_item = @borrowing.borrow_items.find_by book_id: borrow_item_params[:book_id]
    if @borrow_item
      flash[:alert] = "No borrow 2 same books "
    else
      @borrow_item = @borrowing.borrow_items.build borrow_item_params
    end
    @succsess = @borrow_item.save
    @borrowing.save
    save_borrowing @borrowing
    respond_to :js
  end

  def destroy; end

  private

  def get_current_borrowing
    @borrowing = current_borrowing
  end

  def borrow_item_params
    params.require(:borrow_item).permit :book_id
  end
end
