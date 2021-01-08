class BooksController < ApplicationController
  def show
    @book = Book.find params[:id]
    @categories = Category.all
    @authors = Author.all
  end
end
