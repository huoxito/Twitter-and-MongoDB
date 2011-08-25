require 'net/http'

class Twitter
  def initialize
    @twittes = []
  end

  def call
    url = "http://search.twitter.com/search.json?q=%23ruby&result_type=populara" 
    return false unless url
    begin
      req = Net::HTTP.get_response(URI.parse(url))
      res = JSON.parse(req.body)
    rescue JSON::ParserError => e
      raise "Dados corrompidos. Problemas para tratar o JSON. Tente novamente!"
    rescue => e
      raise "Problema para obter os dados do Twitter."
    else
      if res["results"]
        res["results"].each { |r| @twittes << r }
        if res["next_page"]
          call("http://search.twitter.com/search.json#{res["next_page"]}")
        end
      end
    end
    puts @twittes
  end

end
