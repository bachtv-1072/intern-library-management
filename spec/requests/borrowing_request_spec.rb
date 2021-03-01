require "rails_helper"

RSpec.describe BorrowingsController, type: :controller do
  let(:user) {FactoryBot.create :user, role: 0}
  let(:category) {FactoryBot.create :category}
  let(:author) {FactoryBot.create :author}
  let(:publisher) {FactoryBot.create :publisher}

  let!(:book) do
    FactoryBot.create :book, category_id: category.id,
                             publisher_id: publisher.id,
                             author_id: author.id,
                             quantity_borrowed: 8
  end

  let!(:borrowing_two) do
    FactoryBot.create :borrowing, user_id: user.id,
                                  borrow_code: "XATPVCZEBM",
                                  status: :pending
  end
  let!(:borrowing_three) do
    FactoryBot.create :borrowing, user_id: user.id,
                                  borrow_code: "XATPVCZEBM",
                                  status: :accept,
                                  date_borrow: "2021-01-28 17:23:02",
                                  date_pay: "2021-02-03 17:23:02"
  end

  let(:valid_params) {FactoryBot.attributes_for :borrowing}

  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "should render the 'index' template with @borrowings" do
      aggregate_failures do
        expect(response).to render_template :index
        expect(assigns(:borrowings)).to eq [borrowing_two, borrowing_three]
      end
    end
  end

  describe "POST #create" do
    context "valid params" do
      it "should create new borrowing" do
        aggregate_failures do
          expect{
            post :create, params: {user_id: user.id,
              borrowing: valid_params.merge(
                borrow_items_attributes: [
                  {book_id: book.id}
                ])}
          }.to change(Borrowing, :count).by 1
          expect(response).to redirect_to root_path
        end
      end
    end

    context "invalid params" do
      it "can not create new borrowing" do
        aggregate_failures do
          expect{
            post :create, params: {user_id: user.id,
              borrowing: valid_params.merge(
                borrow_items_attributes: [
                  {book_id: nil}
                ])}
          }.to change(Borrowing, :count).by 0
        end
      end
    end
  end
end
