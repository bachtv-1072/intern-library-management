class BorrowingMailer < ApplicationMailer
  %w(new cancel).each do |attribute|
    define_method("#{attribute}_borrowing") do |borrowing|
      @borrowing = borrowing

      mail to: @borrowing.user_email, subject: t("mailer.title")
    end
  end
end
