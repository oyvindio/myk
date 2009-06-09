class ChangeDefaultToClicksOnUrls < ActiveRecord::Migration
  def self.up
      change_column_default(:mykurls, :clicks, 0)
  end

  def self.down
  end
end
