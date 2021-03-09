require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
  let(:user) {FactoryBot.create :user, role: :admin}
  let(:category) {FactoryBot.create :category}
  let(:author) {FactoryBot.create :author}
  let(:publisher) {FactoryBot.create :publisher}

  let!(:book) do
    FactoryBot.create :book, category_id: category.id,
                             publisher_id: publisher.id,
                             author_id: author.id,
                             quantity_borrowed: 8
  end

  before {login user}

  let(:valid_params) {FactoryBot.attributes_for :category}
  let(:invalid_params) {FactoryBot.attributes_for :category, title: nil}


  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "should render the 'index' template with @categories" do
      expect(response).to render_template :index
    end

    it "should render array categories" do
      expect(assigns(:categories).pluck(:id)).to eq [category.id]
    end

    it "should assigns new category" do
      expect(assigns(:category)).to_not eq nil
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "should create new book" do
        expect{
          post :create, format: "js",params: {category: valid_params}
        }.to change(Category, :count).by 1
      end

      it "shold respond to 200 status" do
        expect(response.status).to eq(200)
      end
    end

    context "with invalid params" do
      it "should not create new book" do
        expect{
          post :create, format: "js", params: {category: invalid_params}
        }.to change(Category, :count).by 0
      end
    end
  end

  describe "GET #show" do
    context "when valid param" do
      before {get :show, params: {id: category.id}}

      it "should render the 'show' template with @category" do
        expect(response).to render_template :show
      end

      it "should show colection book belong to category" do
        expect(assigns(:books).pluck(:id)).to eq [book.id]
      end
    end

    context "when invalid param" do
      before {get :show, params: {id: 0}}

      it "should respond to 404" do
        expect(response.status).to eq(404)
      end
    end
  end
end
