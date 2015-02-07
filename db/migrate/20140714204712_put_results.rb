class PutResults < ActiveRecord::Migration
  def change
        add_column :tweets, :result, :string
  end
end
