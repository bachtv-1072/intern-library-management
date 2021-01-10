module SessionsHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find_by id: session[:user_id] if session[:user_id]
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete :current_user_id
    @current_user = nil
  end

  def save_borrowing borrowing
    session[:borrowing_id] = borrowing.id
  end

  def current_borrowing
    if session[:borrowing_id].present?
      Borrowing.find(session[:borrowing_id])
    else
      Borrowing.new
    end
  end
end
