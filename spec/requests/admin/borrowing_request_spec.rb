require "rails_helper"

RSpec.describe Admin::BorrowingsController, type: :controller do
  let(:user) {FactoryBot.create :user, role: :admin}
  let(:category) {FactoryBot.create :category}
  let(:author) {FactoryBot.create :author}
  let(:publisher) {FactoryBot.create :publisher}

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

  before {login user}

  describe "GET #index" do
    before {get :index, params: {page: 1}}

    it "should render the 'index' template with @borrowings_result" do
      expect(response).to render_template :index
    end

    it "should render array borrowings_result" do
      expect(assigns(:borrowings_result)).to eq [borrowing_two, borrowing_three]
    end
  end

  describe "PATCH #update" do
    context "when borrowing is pending" do
      it "with valid param and respond to 200 status" do
        patch :update, format: "js", params: {
          id: borrowing_two.id,
        }
        expect(response.status).to eq(200)
      end

      it "with invalid param and respond to 404 status" do
        patch :update, format: "js", params: {
          id: "",
        }
        expect(response.status).to eq(404)
      end
    end

    context "when borrowing is accept" do
      it "with valid param and respond to 200 status" do
        patch :update, format: "js", params: {
          id: borrowing_three.id,
        }
        expect(response.status).to eq(200)
      end

      it "with invalid param and respond to 404 status" do
        patch :update, format: "js", params: {
          id: "",
        }
        expect(response.status).to eq(404)
      end
    end
  end

  describe "DELETE #destroy" do
    context "when valid params" do
      before {delete :destroy, xhr: true, params: {id: borrowing_two.id}}

      it "should update status order to cancel" do
        expect(assigns(:borrowing).status).to eq "cancel"
      end

      it "should respond to js" do
        expect(response.content_type).to eq("text/javascript; charset=utf-8")
      end

      it "shold respond to 200 status" do
        expect(response.status).to eq(200)
      end
    end

    context "when invalid params" do
      before {delete :destroy, xhr: true, params: {id: ""}}

      it "should respond to 404 status" do
        expect(response.status).to eq(404)
      end
    end
  end
end
