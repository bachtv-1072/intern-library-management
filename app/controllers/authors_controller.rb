class AuthorsController < ApplicationController
  layout false

  def show
    @books = Book.filter_book_by_author params[:id]
  end
end
