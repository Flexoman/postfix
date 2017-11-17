class InboxController < ActionController::Base

  def index
    @message = Message.new
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
                    :body)
    end

end
