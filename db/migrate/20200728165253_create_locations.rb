class CreateLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :locations do |t|
      t.string :city_name
      t.string :state_or_country
    end
  end
end
