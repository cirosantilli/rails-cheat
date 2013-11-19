class MyMailer < ActionMailer::Base
  default from: "gitlab.ciro.santilli@gmail.com"

  # If no other action is taken, renders an email template
  # with the same name as this function under `app/views/my_mailer/<function-name>.(text|html).erb`
  #
  # This function should return an email object, to be delivered by the controller.
  #
  def email0(to)
    mail(to: to, subject: 'email0 subject')
  end
end
