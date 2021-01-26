class Admin::ExportBorrowingsController < Admin::BaseController
  def index
    csv = ExportBorrowing.new Borrowing.all, Borrowing::CSV_ATTRIBUTES
    respond_to do |format|
      format.csv {send_data csv.perform,
        filename: "borrowings.csv"}
    end
  end
end
