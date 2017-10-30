require_relative 'chatbot'
srand 1234

puts "あなたのお名前は？"
username = gets.to_s
user = User.new(username)
docomo_bot1 = Docomo_bot.new('304f5065594c65564558353633776e49693362476b3835434b6a51466979496b6a694e6e544a56384a7034', 'アキラ')
docomo_bot2 = Docomo_bot.new('63764858366d2e5078544879496b7a476a3064464a4c364963775743536444504b704d55432f77792e4432', '直樹')
user_bot1 = LocalUser_bot.new('ももか')
recruit_bot1 = Recruit_bot.new('みずき')

botlist = [docomo_bot1, docomo_bot2, user_bot1, recruit_bot1]
puts "#{username}さん、最初の一言をどうぞ"
msg = gets.to_s

20.times do
  msg = botlist[rand(botlist.size)].send_msg(msg)
end

a='''

puts "初めの一言をお願いします"
msg_recruit_1 = gets.to_s
puts "you) #{msg_recruit_1}"

20.times do
  msg_docomo_1 = docomo_bot1.send_msg(msg_recruit_1)
  puts "d1) #{msg_docomo_1}"
  msg_user_1 = user_bot1.send_msg(msg_docomo_1)
  puts "u1) #{msg_user_1}"
  msg_docomo_2 = docomo_bot2.send_msg(msg_user_1)
  puts "d2) #{msg_docomo_2}"
  msg_recruit_1 = recruit_bot1.send_msg(msg_docomo_2)
  puts "r1) #{msg_recruit_1}"
end
'''