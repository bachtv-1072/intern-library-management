class SearchController < ApplicationController
  def index
    @books = Author.filter_books_by_author(params[:name]).joins(:books)
                  .page(params[:page]).per 5
  end
end
