class HomeController < ApplicationController

  def index
    redirect_to tweets_index_url if session[:user_id]
  end
end
