
class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all

    respond_to do |format|
      format.html
    end
  end
  
  def search
    
    if params[:q].nil?
      redirect_to(root_path)
    else
      @dados = []
      call "http://search.twitter.com/search.json?q=#{params[:q]}"
    end

  end

  def call(url)
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
        res["results"].each { 
          |r| @dados << r 
          Tweet.create({"autor" => r["from_user"], "texto" => r["text"],
                        "tweet_id" => r["id"], "autor_id" => r["from_user_id"]})
        }
        if res["next_page"]
          call("http://search.twitter.com/search.json#{res["next_page"]}")
        end
      end
    end
  end

end
