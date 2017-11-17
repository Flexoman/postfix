class Message
  include ActiveModel::Model
  include ActiveModel::Conversion
  include ActiveModel::Validations

  attr_accessor :email,
                :subject,
                :body

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d-]+)*\.[a-z]+\z/i

  validates :email, presence: true, length: { in: 6..255 },
            format: { with: VALID_EMAIL_REGEX }
  validates :body, presence: true, length: { maximum: 500 }


  def send!
    MessageMailer.notify(self).deliver_now
  end

end