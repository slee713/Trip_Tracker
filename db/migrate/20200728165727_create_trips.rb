class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name
      t.integer :user_id
      t.string :transportation
      t.datetime :start_date
      t.datetime :end_date
    end
  end
end
