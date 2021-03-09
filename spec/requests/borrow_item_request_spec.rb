require "rails_helper"

RSpec.describe BorrowItemsController, type: :controller do
  let(:category) {FactoryBot.create :category}
  let(:author) {FactoryBot.create :author}
  let(:publisher) {FactoryBot.create :publisher}

  let!(:book) do
    FactoryBot.create :book, category_id: category.id,
                             publisher_id: publisher.id,
                             author_id: author.id,
                             quantity_borrowed: 8
  end

  let!(:borrow_item) do
    FactoryBot.create :borrow_item, book_id: book.id
  end

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "should render the 'index' template with @book_borrows" do
      expect(response).to render_template :index
    end

    it "should response to 200" do
      expect(response.status).to eq 200
    end
  end
end
