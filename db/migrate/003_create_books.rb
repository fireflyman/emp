class CreateBooks < ActiveRecord::Migration
  def self.up
    create_table :books do |t|
      t.column:title, :string, :limit => 255, :null => false 
      t.column :publisher_id, :integer, :null => false
      t.column :published_at, :datetime
      t.column :isbn, :string, :limit => 13, :unique => true
      t.column :blurb, :text
      t.column :page_count, :integer
      t.column :price, :float

      t.timestamps
    end
  end

  def self.down
    drop_table :books
  end
end
