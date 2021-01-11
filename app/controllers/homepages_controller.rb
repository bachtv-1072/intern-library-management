class HomepagesController < ApplicationController
  def home
    @limit_new_books = Book.limit Settings.limit_book
  end
end
