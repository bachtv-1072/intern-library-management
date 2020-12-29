class Admin::CategoriesController < Admin::BaseController
  before_action :find_category, only: :show

  def index
    @categories = Category.page(params[:page]).per Settings.panigate.category
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    @index = Category.count
    @status = @category.save
    respond_to :js
  end

  def show
    @books = @category.books
  end

  private

  def find_category
    @category = Category.find params[:id]
  end

  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end
end
