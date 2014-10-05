require 'cinch'
require 'cinch/plugins/title'

version = version = File.new("VERSION", 'r').read.chomp

bot = Cinch::Bot.new do
  configure do |c|
    c.nick = "HTMLBot"
    c.server = "irc.freenode.org"
    c.channels = ["#cinchbots"]
    c.plugins.plugins = [Cinch::Plugins::Title]
    c.plugins.options = {
      Cinch::Plugins::Title => {
        "ignore" => [
          "facebook.com"
        ],
        "user_agent" => 'cinch-title/' + version
      }
    }
  end
end

bot.start
