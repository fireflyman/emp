class Book < ActiveRecord::Base
  belongs_to :publisher
  has_many :authors_books
  has_many :authors, :through => :authors_books  
  
  validates_length_of :title, :in => 1..255
  validates_presence_of :publisher
  validates_presence_of :authors
  validates_presence_of :published_at
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :price
  validates_format_of :isbn, :with => /[0-9\-a-zA-Z]{13}/
  validates_uniqueness_of :isbn
end
