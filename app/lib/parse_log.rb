# require 'pry'
# require 'awesome_print'
# require 'oj'
# require 'json'
# require "postfix_status_line"
# require "active_support"
# require 'time'

class LogParser

  def initialize path
    @path = path
  end

  def emit &block
    open(@path) do |file|
      file.each_line do |line|
        next if skip(line)

        json = PostfixStatusLine.parse(line, mask: false, parse_time: true)

        yield json
      end
    end
  end

  def skip(line)
    line.exclude?('status=')
  end

end

# parser = LogParser.new( ARGV[0] )
# parser.emit do |hash|
#   # hash = hash&.except('hostname')
#   hash = JSON.pretty_generate(hash)
#   # if hash
#   #   a[hash['to']] = hash['status']
#   # end
#   # hash = Oj.dump(hash)

#   # Save
#   open('./json', 'a') { |file| file.puts hash }
# end
