class BooksController < ApplicationController
  def index
    params[:id] = nil if Book.pluck(:publisher_id).exclude?(params[:id].to_i)
    @books_to_publisher = Book.filter_by_publisher params[:id]
    @books = @books_to_publisher.page(params[:page])
                                .per Settings.panigate.book
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
    @rating = Rating.new
  end
end
