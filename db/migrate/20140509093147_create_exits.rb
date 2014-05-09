class CreateExits < ActiveRecord::Migration
  def change
    create_table :exits do |t|
      t.integer :location_id
      t.integer :destination_location_id

      t.timestamps
    end
  end
end
