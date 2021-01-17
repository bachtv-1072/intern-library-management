class BooksController < ApplicationController
  def index
    @books = Book.page(params[:page]).per Settings.panigate.book
    @categories = Category.all
    @authors = Author.all
  end

  def show
    @book = Book.find params[:id]
    @categories = Category.all
    @authors = Author.all
    @borrow_item = @book.borrow_items.build
    @comment = Comment.new
    @comments = @book.comments
  end
end
