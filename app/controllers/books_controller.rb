class BooksController < ApplicationController
  def show
    @book = Book.find params[:id]
    @categories = Category.all
    @authors = Author.all
    @borrow_item = @book.borrow_items.build
  end

  def index
    @books = Book.all
  end
end
