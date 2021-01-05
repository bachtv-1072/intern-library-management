class Admin::PublishersController < Admin::BaseController
  def index
    @publishers = Publisher.page(params[:page]).per Settings.panigate.category
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    @status = @publisher.save ? :success : @publisher.errors.messages
    respond_to do |format|
      format.js
    end
  end
  private

  def publisher_params
    params.require(:publisher).permit PUBLISHER::PUBLISHER_PARAMS
  end
end
