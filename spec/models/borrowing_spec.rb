require "rails_helper"

RSpec.describe Borrowing, type: :model do
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
  let!(:borrow_item_first) do
    FactoryBot.create :borrow_item, borrowing_id: borrowing_three.id,
                                    book_id: book.id
  end

  describe "associations" do
    it "belong to user" do
      is_expected.to belong_to(:user).optional
    end

    it "has many borrow_items" do
      is_expected.to have_many(:borrow_items).dependent :destroy
    end

    it "has many books" do
      is_expected.to have_many(:books).through :borrow_items
    end
  end

  describe "nested attributes" do
    it "borrow_items" do
      is_expected.to accept_nested_attributes_for :borrow_items
    end
  end

  describe "enums" do
    it "status" do
      is_expected.to define_enum_for(:status)
                 .with_values pending: 0, accept: 1, cancel: 2, payed: 3
    end
  end

  describe ".return_quantity" do
    it "return quantity when payed book" do
      borrowing_three.update status: Settings.enum.payed
      expect(borrowing_three.return_quantity).to eq [borrow_item_first]
    end
  end

  describe ".accept_borrowing" do
    it "return ActionMailer when accept borrowing" do
      expect(borrowing_two.accept_borrowing.class).to eq ActionMailer::MailDeliveryJob
    end

    it "return object haved to accept" do
      expect(borrowing_two.accept_borrowing.arguments.last[:args]).to eq [borrowing_two]
    end
  end

  describe ".borrowing_cancel" do
    it "return ActionMailer when cancel borrowing" do
      expect(borrowing_two.borrowing_cancel.class).to eq ActionMailer::MailDeliveryJob
    end

    it "return object haved to cancel" do
      expect(borrowing_two.borrowing_cancel.arguments.last[:args]).to eq [borrowing_two]
    end
  end

  describe ".generate_borrow_code" do
    let(:borrowing) {FactoryBot.create(:borrowing)}

    it "return code bofore create borrowing" do
      expect(borrowing.borrow_code).to be_truthy
    end
  end

  describe "#ransackable_attributes" do
    context "when auth_object is nil" do
      subject { Borrowing.ransackable_attributes }

      it { should include "date_borrow" }
      it { should include "date_pay" }
      it { should include "status" }
      it { should include "borrow_code" }
    end

    context "with auth_object :admin" do
      subject { Borrowing.ransackable_attributes :admin }

      it { should include "id" }
      it { should include "date_borrow" }
      it { should include "date_pay" }
      it { should include "status" }
      it { should include "user_id" }
      it { should include "created_at" }
      it { should include "updated_at" }
      it { should include "borrow_code" }
      it { should include "deleted_at" }
    end
  end
end
