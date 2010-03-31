class Book < ActiveRecord::Base
  belongs_to :publisher
  has_attached_file :photo, 
                           :styles => { :small => "150*150>"}
  has_many :authors_books
  has_many :authors, :through => :authors_books  
  acts_as_ferret 
  #acts_as_ferret :fields => [:title, :author_names]
  
  validates_length_of :title, :in => 1..255
  validates_presence_of :publisher
  #validates_presence_of :authors
  validates_presence_of :published_at
  validates_numericality_of :page_count, :only_integer => true
  validates_numericality_of :price
  validates_format_of :isbn, :with => /[0-9\-a-zA-Z]{13}/
  validates_uniqueness_of :isbn
  
  #photo validates
  validates_attachment_presence :photo    
  validates_attachment_size :photo, :less_than => 5.megabytes    
  validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/gif', 'image/png'] 
  
  def author_names
   self.publishers.map do |p|
     a.name
    end
   end
  
end
