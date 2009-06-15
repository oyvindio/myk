class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :lat
      t.string :lng
      t.integer :mykurl_id
      t.string :city
      t.string :country
      t.string :ip
      t.string :domain

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
