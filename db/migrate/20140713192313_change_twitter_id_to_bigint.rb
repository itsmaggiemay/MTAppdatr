class ChangeTwitterIdToBigint < ActiveRecord::Migration
  def change
    remove_column :tweets, :twitter_id
    add_column :tweets, :twitter_id, :bigint
  end
end
