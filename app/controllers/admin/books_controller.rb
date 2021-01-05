class Admin::BooksController < Admin::BaseController
  def new
    @book = Book.new
  end

  def index
    @books = Book.page(params[:page]).per Settings.panigate.category
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "categories.message.sucsses"
      redirect_to admin_books_path
    else
      flash.now[:alert] = t "categories.message.failer"
      render :new
    end
  end

  private

  def book_params
    params.require(:book).permit Book::BOOK_PARAMS
  end
end
