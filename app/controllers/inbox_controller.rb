require  "#{Rails.root}/app/lib/parse_log"

class InboxController < ActionController::Base
  # layout 'application'

  def index
    @message = Message.new

    @from = 'info'
    @subject = 'Greeting, it`s news'
    @rand_body = 'Up is opinion message manners correct hearing husband my. '

    log_path = "/var/log/*"

    # paths = Dir.glob(log_path).select do |path|
    #   path.match(/mail.log/)
    # end
    paths = ['/var/log/mail.log']

    @emails = []

    now = 1.day.ago.to_i
    paths.each do |path|
      parser = LogParser.new( path )

      parser.emit do |hash|
        @emails << hash if hash['epoch'] > now
      end

    end



    @emails = @emails.sort_by {|data| data['epoch']}.reverse
    @emails = @emails[1..10000]

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
