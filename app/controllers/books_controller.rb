class BooksController < ApplicationController
  def show
    @book = Book.find params[:id]
    @categories = Category.all
    @authors = Author.all
    @borrow_item = @book.borrow_items.build
    if logged_in?
      user_rating = current_user.ratings.find_by(product_id: params[:id])
      @rating =
        if user_rating.present?
          user_rating
        else
          current_user.ratings.build(product_id: params[:id])
        end
    end
  end
end
