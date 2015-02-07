class Tweet < ActiveRecord::Base
  belongs_to :friend

  def self.exists?(tag_id, twitter_text)
    where(:tweet_text => twitter_text, :tag_id => tag_id).length > 0
  end

   def analysis
      self.result = Datumbox.new.TwitterSentimentAnalysis(text: self.tweet_text)
      self.save!
   end

end


# # 
#   def self.initialize_streaming_twitter_client(stream)
#     client = Twitter::Streaming::Client.new do |config|
#       secret = STREAM_API_SECRETS[stream]
#       config.consumer_key        = Rails.application.secrets.send("twitter_api_key#{secret}")
#       config.consumer_secret     = Rails.application.secrets.send("twitter_api_key_secret#{secret}")
#       config.access_token        = Rails.application.secrets.send("twitter_user_api_key#{secret}")
#       config.access_token_secret = Rails.application.secrets.send("twitter_user_api_key_secret#{secret}")
#     end
#   end

#   def self.initialize_streaming_twitter_client_nyc
#     initialize_streaming_twitter_client(:nyc)
#   end

#   def self.initialize_streaming_twitter_client_twubbles
#     initialize_streaming_twitter_client(:twubbles)
#   end

#   def self.initialize_streaming_twitter_client_languages
#     initialize_streaming_twitter_client(:languages)
#   end

#   def self.initialize_streaming_twitter_client_tech_companies
#     initialize_streaming_twitter_client(:tech_companies)
#   end

#   def score_sentimentality(sentiment_analyzer = Sentimental.new)
#     self.sentiment_summary = sentiment_analyzer.get_sentiment(self.text)
#     self.sentiment_score = sentiment_analyzer.get_score(self.text)
#   end