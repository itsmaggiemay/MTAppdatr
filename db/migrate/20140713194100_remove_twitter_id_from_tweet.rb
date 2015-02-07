class RemoveTwitterIdFromTweet < ActiveRecord::Migration
  def change
    remove_column :tweets, :twitter_id
  end
end
