class Admin::BooksController < Admin::BaseController
  # before_action :find_category, only: %i(new create)
  def new
    @book = Book.new
    @categories = Category.all
    @publishes = Publisher.all
  end

  def index
    @books = Book.page(params[:page]).per Settings.panigate.category
  end

  def create; end
  private

  def book_params
    params.require(:category).permit Book::BOOK_PARAMS
  end
end
