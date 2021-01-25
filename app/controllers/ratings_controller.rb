class RatingsController < ApplicationController
  before_action :require_login, only: :create

  def create
    @book = Book.find rating_params[:book_id]
    @rating = @book.ratings.find_by user_id: current_user.id
    if @rating
      @rating.update_attribute :point, params[:rating][:point].to_i
    else
      @rating = current_user.ratings.build rating_params
      @rating.save
    end
  end

  private

  def rating_params
    params.require(:rating).permit Rating::RATING_PARAMS
  end
end
