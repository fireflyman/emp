class Book < ActiveRecord::Base
  
  has_many :cart_items
  has_many :carts, :through => :cart_items
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
with_options :allow_blank => true do |v|  
  #photo validates
  #use it let me can't del the photo
  #v.validates_attachment_presence :photo    
  v.validates_attachment_size :photo, :less_than => 5.megabytes    
  v.validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/jpg', 'image/gif', 'image/png'] 
end

  def author_names
   self.publishers.map do |p|
     a.name
    end.join(", ") rescue ""
  end
  
  def self.latest
    find :all, :limit => 10, :order => "books.id desc",
                :include => [:authors, :publisher]
  
  end
   
=begin
   def delete_photo=(value) 
     @delete_photo = !value.to_i.zero? 
   end
 
   def delete_photo 
     !!@delete_photo
   end
  alias_method :delete_photo?, :delete_photo
  before_validation :clear_photo

   def clear_photo
    self.photo = nil if delete_photo? && !photo.dirty? 
   end
=end

end
