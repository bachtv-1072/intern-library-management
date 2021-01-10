class CategoriesController < ApplicationController
  def index
    @categories = Category.all
    @authors = Author.all
    @books = Book.all
  end
end
