require 'json'
require 'net/https'

class Recruit_bot
  @@api_key="ACZea2U2mBuTJBIYbj0ryK3Wi9rMorDU"
  @@end_point="https://api.a3rt.recruit-tech.co.jp/talk/v1/smalltalk"

  def initialize(name)
    @msg=""
    @query=""
    @name=name.to_s
  end

  def send_msg(query)
    unless query.instance_of?(String) && query.length <= 50
      # valid
      puts "#{query}は文字列ではないか、長すぎます。"
      puts "文字列長は50文字まで指定できます"
    else
      # set http_handler
      uri = URI.parse(@@end_point)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      @req = Net::HTTP::Post.new(uri.path)
      # send query
      @query = query
      @req.set_form_data({'apikey' => @@api_key, 'query' => @query})
      @res = http.request(@req)
      raise() unless @res
    end

    # check http status
    if @res
      @result = JSON.parse(@res.body)
      if @result["status"] == 2000
        @msg = "返事がない。ただの屍のようだ。"
        return @msg
      elsif @result["status"] != 0
        # error
        puts "ステータスコードが正しくありませんでした。"
        puts @result
        raise()
      end
    end

    # set message
    @msg = @result["results"][0]["reply"]

    # return message
    puts "#{@name}さん)  #{@msg}"
    @msg

  end

end

class Docomo_bot
  @@api_key="304f5065594c65564558353633776e49693362476b3835434b6a51466979496b6a694e6e544a56384a7034"
  @@end_point="https://api.apigw.smt.docomo.ne.jp/dialogue/v1/dialogue"
  #@@cliant_id="w1CXzYY0JlTrbpIZEJjTQPMU2SaQlDsiaxzcPV7XYr1g"
  #@@cliant_secret=">hdin;3b.YZE;h]'fTy,"

  def initialize(apikey, name)
    unless apikey
      raise()
    end
    @api_key = apikey
    @content = ""
    @mode = ""
    @name = name.to_s
  end

  def send_msg(query)
    unless query.instance_of?(String) && query.length <= 50
      # valid
      puts "#{query}は文字列ではないか、長すぎます。"
      puts "文字列長は50文字まで指定できます"
    else
      @uri = URI.parse(@@end_point)
      @uri.query = 'APIKEY=' + @api_key
      # set http_handler
      https = Net::HTTP.new(@uri.host, @uri.port)
      https.use_ssl = true
      @req = Net::HTTP::Post.new(@uri.request_uri, {'Content-Type' => 'application/json'})
      body = {"utt" => query}
      body["context"] = @context if @context
      body["mode"] = @mode if @mode
      @req.body = body.to_json
      @res = https.request(@req)

      raise() unless @res
    end

    # check http status
    if @res
      if @res.code == "500"
        msg = "返事がない。ただの屍のようだ。"
        return msg
      elsif @res.code != "200"
        # error
        puts "ふにゃあ〜"
        puts @req
        puts @res
        raise()
      end
    end

    # set message & content
    if @res.code == "200"
      begin
        body_hash = JSON.parse(@res.body)
        msg = body_hash["utt"]
      rescue
        msg = "そうですか"
      end
      @content = body_hash["context"]
      @mode = body_hash["mode"]
    end

    # return message
    puts "#{@name}さん)  #{msg}"
    msg
  end

end

class LocalUser_bot
  @@api_key="be114218bf4f06d73e9d"
  @@end_point="https://chatbot-api.userlocal.jp/api/chat"
  def initialize(name)
    @message = ""
    @name = name.to_s
  end

  def send_msg(query)
    unless query.instance_of?(String) && query.length <= 50
      # valid
      puts "#{query}は文字列ではないか、長すぎます。"
      puts "文字列長は50文字まで指定できます"
    else
      @uri = URI.parse(@@end_point)
      @uri.query = 'key=' + @@api_key
      @uri.query += '&message=' + query
      https = Net::HTTP.new(@uri.host, @uri.port)
      https.use_ssl = true
      @req = Net::HTTP::Post.new(@uri.request_uri)
      @res = https.request(@req)

      raise() unless @res
    end

    if @res
      body_hash = JSON.parse(@res.body)
      unless body_hash['status'] == 'success'
        puts body_hash
        raise()
      end
    end

    msg = body_hash["result"]
    puts "#{@name}さん)  #{msg}"
    msg
  end
end

class User
  def initialize(name)
    @name = name.to_s
  end

  def send_msg(query)
    puts 'あなたの番です'
    msg = gets.to_s
    puts "#{@name}さん)  #{msg}"
    msg
  end
end