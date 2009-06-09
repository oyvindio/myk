class CreateMykurls < ActiveRecord::Migration
  def self.up
    create_table :mykurls do |t|
      t.string :url
      t.integer :clicks
      t.integer :tweets
      t.integer :user_id
      t.string :state
      t.string :token

      t.timestamps
    end
  end

  def self.down
    drop_table :mykurls
  end
end
