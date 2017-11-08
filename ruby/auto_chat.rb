require_relative 'chatbot'
require 'rubygems'
require 'socket.io-client-simple'


# init params
srand 1234
docomo_bot1 = Docomo_bot.new('304f5065594c65564558353633776e49693362476b3835434b6a51466979496b6a694e6e544a56384a7034', 'アキラ')
docomo_bot2 = Docomo_bot.new('63764858366d2e5078544879496b7a476a3064464a4c364963775743536444504b704d55432f77792e4432', '直樹')
user_bot1 = LocalUser_bot.new('ももか')
recruit_bot1 = Recruit_bot.new('みずき')

#botlist = [docomo_bot1, docomo_bot2, user_bot1, recruit_bot1]
botlist = [docomo_bot1, docomo_bot2, user_bot1]
#botlist = [docomo_bot1, docomo_bot2]

socket = SocketIO::Client::Simple.connect 'http://localhost:8080'

msg = ""
counter = 5
#msg = botlist[rand(botlist.size)].send_msg(msg)


socket.on :connect do  ## 接続イベント
  puts "connect!!!"
end

socket.on :disconnect do  ## 切断イベント
  puts "disconnected!!"
end

## サーバーからイベント"chat"がemitされたら、このコールバックが呼ばれる
socket.on :chat do |data|
  puts "> " + data
  msg = data
end


loop do
  if counter < 1
    counter = 5
    if msg != ""
        msg = botlist[rand(botlist.size)].send_msg(msg)
        socket.emit :chat, msg
    end
  end

  ## サーバーにchatイベントを送る
  #socket.emit :chat, {:msg => msg, :at => Time.now}
  #socket.emit :chat, msg
  counter -= 1
  sleep 1
end
