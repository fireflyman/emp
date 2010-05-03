class AddCacheTagListToBook < ActiveRecord::Migration
  def self.up
    add_column :books, :cache_tag_list, :string
  end

  def self.down
    remove_column :books, :cache_tag_list
  end
end
