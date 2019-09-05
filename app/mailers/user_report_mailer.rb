class UserReportMailer < ApplicationMailer
    default :to => "acomertesting@gmail.com"

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_report_email(user, review)
      @user = user
      @review = review
      mail( :from => "#{user.name} <#{user.email}>",
      :subject => "Reporte de Opinion Numero: #{review.id}")
    end
end
