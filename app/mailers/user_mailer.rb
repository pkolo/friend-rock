class UserMailer < ApplicationMailer
  def registration_confirmation(user)
    @user = user
    mail :to => "#{user.username} <#{user.email}>", :subject => "Hello! Please Verify Your Email!"
  end
end
