class Admin::AuthorsController < Admin::BaseController
  def index
    @authors = Author.page(params[:page]).per Settings.panigate.category
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    @index = Author.count
    @status = @author.save
    respond_to :js
  end

  private

  def author_params
    params.require(:author).permit Author::AUTHOR_PARAMS
  end
end
