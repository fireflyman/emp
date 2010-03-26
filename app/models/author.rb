class Author < ActiveRecord::Base
  has_many :authors_books
  has_many :books, :through => :authors_books  
  validates_presence_of :first_name, :last_name
  def name
   "#{first_name} #{last_name}"
  end
  
end
