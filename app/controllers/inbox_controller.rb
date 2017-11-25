class InboxController < ActionController::Base
  layout 'application'

  def index
    @message = Message.new

    @from = 'info.europeanexperts.com'

    @subject = 'Greeting, it`s news'

    @rand_body = 'Up is opinion message manners correct hearing husband my. Disposing commanded dashwoods cordially depending at at. Its strangers who you certainty earnestly resources suffering she. Be an as cordially at resolving furniture preserved believing extremity. Easy mr pain felt in. Too northward affection additions nay. He no an nature ye talent houses wisdom vanity denied. '
  end

  def create
    @message = Message.new(email_params)

    if @message.valid?
      @message.send!
      flash[:notice] = 'Sending'
      redirect_to root_path
    else
      flash[:error] = 'Error'
      redirect_to root_path
    end
  end

  private

    def email_params
      params.permit(:email,
                    :subject,
                    :body,
                    :from)
    end

end
