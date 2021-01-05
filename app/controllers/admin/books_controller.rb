class Admin::BooksController < Admin::BaseController
  def index
    @books = Book.page(params[:page]).per Settings.panigate.category
  end
end
