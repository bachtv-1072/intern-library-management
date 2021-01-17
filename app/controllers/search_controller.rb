class SearchController < ApplicationController
  layout "layouts/search/application"

  def index
    @books = Book.search_by_name params[:name]
  end
end
