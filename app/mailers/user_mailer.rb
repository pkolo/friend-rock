class UserMailer < ApplicationMailer
  # Sign-up related
  def registration_confirmation(user)
    @user = user
    mail to: "#{user.username} <#{user.email}>", subject: "Hello! Please Verify Your Email!"
  end

  # Project related
  def new_project_created(project, user)
    @project = project
    @user = user

    mail to: "#{user.username} <#{user.email}>", subject: "New Project - #{project.name}"
  end
end
