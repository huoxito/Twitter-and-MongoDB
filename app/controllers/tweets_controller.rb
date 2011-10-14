require 'net/http'
class TweetsController < ApplicationController

  def index
    @all = Tweet.count
    @tweets = Tweet.sort(:id.desc).limit(50)

    respond_to do |format|
      format.html
    end
  end
  
  def search
    if params[:q].nil?
      redirect_to root_path
    else
      @dados = []
      url = URI.encode("http://search.twitter.com/search.json?q=#{params[:q]}")
      call url
    end
  end

  def call(url)
    return false unless url
    req = Net::HTTP.get_response(URI.parse(url))
    res = JSON.parse(req.body)
    if res["results"]
      res["results"].each { 
        |r| @dados << r 
        Tweet.create!(r)
      }
      if res["next_page"]
        call("http://search.twitter.com/search.json#{res["next_page"]}")
      end
    end
  end

end
