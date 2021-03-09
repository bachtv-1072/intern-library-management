require "rails_helper"

RSpec.describe Admin::PublishersController, type: :controller do
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

  let(:valid_params) {FactoryBot.attributes_for :publisher}
  let(:invalid_params) {FactoryBot.attributes_for :publisher, name: nil}


  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "should render the 'index' template with @categories" do
      expect(response).to render_template :index
    end

    it "should render array categories" do
      expect(assigns(:publishers).pluck(:id)).to eq [publisher.id]
    end

    it "should assigns new category" do
      expect(assigns(:publisher)).to_not eq nil
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "should create new book" do
        expect{
          post :create, format: "js", params: {publisher: valid_params}
        }.to change(Publisher, :count).by 1
      end
    end

    context "with invalid params" do
      it "should not create new book" do
        expect{
          post :create, format: "js", params: {publisher: invalid_params}
        }.to change(Publisher, :count).by 0
      end
    end
  end
end
