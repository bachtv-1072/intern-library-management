require "rails_helper"

RSpec.describe Admin::BooksController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:author) {FactoryBot.create :author}
  let(:publisher) {FactoryBot.create :publisher}
  let(:user) {FactoryBot.create :user, role: :admin}

  let!(:book) do
    FactoryBot.create :book, category_id: category.id,
                             publisher_id: publisher.id,
                             author_id: author.id,
                             quantity_borrowed: 8
  end

  before {login user}

  let(:valid_params) {FactoryBot.attributes_for :book,
                                                category_id: category.id,
                                                publisher_id: publisher.id,
                                                author_id: author.id}
  let(:invalid_params) {FactoryBot.attributes_for :book,
                                                  category_id: category.id,
                                                  publisher_id: publisher.id,
                                                  author_id: author.id,
                                                  name: nil}

  describe "GET #new" do
    before {get :new}

    it "should render the 'new' template" do
      expect(response).to render_template :new
    end

    it "should found" do
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET #index" do
    before {get :index, params: {page: 1}}
    it "should render the 'index' template with @books" do
      expect(response).to render_template :index
    end

    it "should render array book" do
      expect(assigns(:books).pluck(:id)).to eq [book.id]
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "should create new book" do
        expect{
          post :create, params: {book: valid_params}
        }.to change(Book, :count).by 1
      end

      it "should redirect to admin_books_path" do
        post :create, params: {book: valid_params}
        expect(response).to redirect_to admin_books_path
      end
    end

    context "with invalid params" do
      it "should not create new book" do
        expect{
          post :create, params: {book: invalid_params}
        }.to change(Book, :count).by 0
      end

      it "should render the 'new' template" do
        post :create, params: {book: invalid_params}
        expect(response).to render_template :new
      end
    end
  end
end
