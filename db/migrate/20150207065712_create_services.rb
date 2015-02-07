class CreateServices < ActiveRecord::Migration
  def change
 	create_table :services do |t|
      t.string :name
      t.string :traffic
      t.text   :description
      t.text   :more_detail
      t.text   :delay
      t.text   :change

      t.timestamps	
    end
  end
end

