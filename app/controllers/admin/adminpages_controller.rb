class Admin::AdminpagesController < Admin::BaseController
  def home
    @total_users = User.user.size
    @total_borrowings = Borrowing.all.size
    @total_books = Book.all.size
    @total_comments = Comment.all.size
  end
end
