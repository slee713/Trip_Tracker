class CreateStops < ActiveRecord::Migration[5.2]
  def change
    create_table :stops do |t|
      t.integer :trip_id
      t.integer :location_id
      t.integer :rating
      t.text :description
    end
  end
end
