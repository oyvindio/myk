class AddTweetsandfaceToMykurl < ActiveRecord::Migration
  def self.up
    add_column :mykurls, :twitter_count, :integer,:default=>0
    add_column :mykurls, :facebook_count, :integer,:default=>0
  end

  def self.down
    remove_column :mykurls, :facebook_count
    remove_column :mykurls, :twitter_count
  end
end
