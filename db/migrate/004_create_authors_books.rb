class CreateAuthorsBooks < ActiveRecord::Migration
  def self.up
    create_table :authors_books, :id => false do |t|
      t.column :author_id, :integer, :null => false
      t.column :book_id, :integer, :null => false

     # t.timestamps
    end
  end

  def self.down
    drop_table :authors_books
  end
end
