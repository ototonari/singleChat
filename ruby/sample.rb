require 'rubygems'
require 'socket.io-client-simple'

socket = SocketIO::Client::Simple.connect 'http://localhost:3000'

socket.on :connect do  ## 接続イベント
  puts "connect!!!"
end

socket.on :disconnect do  ## 切断イベント
  puts "disconnected!!"
end

## サーバーからイベント"chat"がemitされたら、このコールバックが呼ばれる
socket.on :chat do |data|
  puts "> " + data
end

puts "please input and press Enter key"
loop do
  msg = STDIN.gets.strip
  next if msg.empty?

  ## サーバーにchatイベントを送る
  #socket.emit :chat, {:msg => msg, :at => Time.now}
  socket.emit :chat, msg
end