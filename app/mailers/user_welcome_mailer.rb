class UserWelcomeMailer < ApplicationMailer
    def welcome_email(user)
      @user = user
      mail(to: @user.email, subject: 'Bienvenido a Acomer!')
    end
end
