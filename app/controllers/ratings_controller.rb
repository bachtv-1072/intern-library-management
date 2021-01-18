class RatingsController < ApplicationController
  before_action :require_login, only: :create

  def create
    @rating = current_user.ratings.build rating_params
    @message = @rating.save
    respond_to :js
  end

  def update
    @product = Product.find(rating_params[:product_id])
    @rating = Rating.find_by(product_id: @product.id, user_id: params[:user_id])
    respond_to :js
  end

  private

  def rating_params
    params.require(:rating).permit Rating::RATING_PARAMS
  end
end
