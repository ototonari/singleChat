/bin/bash

cd /home/ubuntu/workspace/singleChat/node/
node ./index.js &
cd /home/ubuntu/workspace/singleChat/ruby/
ruby ./auth_chat.rb &
