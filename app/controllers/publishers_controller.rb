class PublishersController < ApplicationController
  layout false

  def show
    @books = Book.filter_book_by_publisher params[:id]
  end
end
