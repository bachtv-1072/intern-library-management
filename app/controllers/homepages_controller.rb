class HomepagesController < ApplicationController
  def home
    @limit_new_books = Book.limit 4
  end
end
