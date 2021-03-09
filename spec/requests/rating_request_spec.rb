require "rails_helper"

RSpec.describe RatingsController, type: :controller do
  let(:user) {FactoryBot.create :user}
  let(:category) {FactoryBot.create :category}
  let(:author) {FactoryBot.create :author}
  let(:publisher) {FactoryBot.create :publisher}
  let!(:book) do
    FactoryBot.create :book, category_id: category.id,
                             publisher_id: publisher.id,
                             author_id: author.id,
                             quantity_borrowed: 8
  end

  let(:valid_params) {FactoryBot.attributes_for :rating,
                                                book_id: book.id,
                                                point: 4}
  let(:invalid_params) {FactoryBot.attributes_for :rating,
                                                  book_id: book.id,
                                                  point: nil}

  before {login user}

  describe "POST #create" do
    context "with valid params" do
      it "should has a 200 status code" do
        post :create, params: {rating: valid_params,
          book_id: book.id}, xhr: true
        expect(response.status).to eq(200)
      end

      it "should create new rating point book" do
        expect{
          post :create, params: {rating: valid_params,
            book_id: book.id}, xhr: true}.to change(Rating, :count).by 1
      end
    end

    context "with invalid params" do
      it "should not create new rating point book" do
        expect{
          post :create, params: {rating: invalid_params,
            book_id: book.id}, xhr: true
        }.to change(Rating, :count).by 0
      end
    end

    context "rating point exist of the book" do
      before {post :create, params: {rating: valid_params, book_id: book.id},
          xhr: true}

      it "update point for the book" do
        expect{
          post :create, params: {rating: valid_params, book_id: book.id,
            point: 4}, xhr: true
        }.to change(Rating, :count).by 0
      end
    end
  end
end
