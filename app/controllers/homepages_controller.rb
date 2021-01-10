class HomepagesController < ApplicationController
  def home
    @limit_new_books = Book.limit 4
    @products = Author.filter_books_by_author(params[:filter_books_by_author]).joins(:books)
  end
end
