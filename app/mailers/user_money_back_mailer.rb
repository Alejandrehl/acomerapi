class UserMoneyBackMailer < ApplicationMailer
    default to: "acomertesting@gmail.com"

    # send a signup email to the user, pass in the user object that   contains the user's email address
    def send_money_email(user, payment)
      @user = user
      @payment = payment
      mail( from: "#{@user.email}",
      :subject => "Solicitar Dinero")
    end
end
