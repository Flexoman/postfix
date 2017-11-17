class MessageMailer < ApplicationMailer
  layout false

  def notify(message)
    email   = message.email
    subject = message.subject
    body    = message.body

    mail(to: email, subject: subject) do |format|
      format.text { render plain: ActionView::Base.full_sanitizer.sanitize(body) }
      format.html { render html: body.html_safe }
    end
  end
end