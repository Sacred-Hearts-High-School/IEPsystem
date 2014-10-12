class UserMailer < ActionMailer::Base
  default from: "詹嘉隆 <taichis@shsh.ylc.edu.tw>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.confirm.subject
  #
  def confirm(email)
    @greeting = "Hi"
    @message = "Thank you for confirmation! user_mailer.rb"

    mail to: email, subject: "Registered"
  end

  def iep1_email(id)
     @task = Task.find(id)
     mail to: "#{@task.teacher.name} <#{@task.teacher.email}>", subject: "請協助"+@task.title
  end

end
