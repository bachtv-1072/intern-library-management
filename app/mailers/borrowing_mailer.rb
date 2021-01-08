class BorrowingMailer < ApplicationMailer
  def new_borrowing
    @borrowing = params[:borrowing]

    mail to: @borrowing.user_email, subject: t("mailer.title")
  end
end
