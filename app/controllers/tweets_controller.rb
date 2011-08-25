require 'twitter.rb'

class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all

    respond_to do |format|
      format.html
    end
  end

  def getTweets
  end

end
