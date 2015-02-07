require 'open-uri'
require 'nokogiri'

class TweetsController < ApplicationController

   def index
    if not params[:hashtag].nil?
        client = Twitter::REST::Client.new do |config|
          config.consumer_key        = ENV["TWITTER_CONSUMER_KEY"]
          config.consumer_secret     = ENV["TWITTER_CONSUMER_SECRET"]
        end
       
        # try to find twitter #ntrain
        # if the #ntrain is not found, the 'twitter' gem raises an error
        begin
          h = client.search(params[:hashtag])
          rescue Exception => error
          # "catches" the error and allow the program to resume without crashing
          # and assigning the error message to a variable to be used to display it in the view
          @error_message = error.message
        end

        # if an error was raised (the user is not found on twitter), don't run the below code
        # only run the below code if the user was successfully found (no error was thrown by f = client.user(params[:hashtag]))
      if not h.nil?
         hashtag_model = Tag.save_tag_data(h, current_user.id)

          begin
            get_hashtagtweets(client, params[:hashtag]).each do |tweet|
              unless Tweet.exists?(hashtag_model.id, tweet[:tweet_text])
              new_tweet = Tweet.create(tweet.merge({ :tag_id => hashtag_model.id }))
              new_tweet.analysis
              end
            end
            rescue Exception => error
            @error_message = error.message
          end

         positive_tweets = hashtag_model.tweets.select { |tweet| tweet.result == 'positive' }
         negative_tweets = hashtag_model.tweets.select { |tweet| tweet.result == 'negative' }
         total = positive_tweets.length + negative_tweets.length

        if total > 0
          @hashtag = h
          @positivity_percentage = (positive_tweets.length.to_f / total * 100).ceil
          @tweets = hashtag_model.tweets
     
        end
      end
    end
   end

  private
 def get_hashtagtweets(client, hashtag)
  client.search("##{hashtag} -rt", :result_type => "recent").take(20).collect do |tweet|
        {:tweet_text => tweet.text,
         :tweet_date => tweet.created_at}
    end
  end

end

