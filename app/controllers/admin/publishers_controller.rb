class Admin::PublishersController < Admin::BaseController
  def index
    @publishers = Publisher.page(params[:page]).per Settings.panigate.category
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    @index = Publisher.count
    @status = @publisher.save
    respond_to :js
  end

  private

  def publisher_params
    params.require(:publisher).permit Publisher::PUBLISHER_PARAMS
  end
end
