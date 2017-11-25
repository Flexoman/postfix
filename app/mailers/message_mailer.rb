class MessageMailer < ApplicationMailer
  layout false

  def notify(message)
    email   = message.email
    subject = message.subject
    body    = message.body
    body    = message.from

    mail(
      to: email,
      subject: subject,
      from: from
    ) do |format|
      format.text { render plain: ActionView::Base.full_sanitizer.sanitize(body) }
      format.html { render html: body.html_safe }
    end
  end
end