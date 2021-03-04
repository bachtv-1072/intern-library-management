class SendEmailCancelBorrowingJob < ApplicationJob
  queue_as :default

  def perform borrowing
    BorrowingMailer.cancel_borrowing(borrowing).deliver_later
  end
end
