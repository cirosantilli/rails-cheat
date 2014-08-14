class MyMailer < ActionMailer::Base
  default from: "gitlab.elearn@gmail.com"

  # If no other action is taken, renders an email template
  # with the same name as this function under `app/views/my_mailer/<function-name>.(text|html).erb`
  #
  # This function should return an email object, to be delivered by the controller.
  #
  def email0(to, from)
    mail(
      to: to,
      from: from,
      subject: 'email0 subject'
    )
  end
end
