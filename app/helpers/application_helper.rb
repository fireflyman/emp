# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
include TagsHelper  
 def add_book_link(text, book)
    link_to_remote text, {:url => {:controller => "cart",
              :action => "add", :id => book}},
            {:title => "Add to Cart",
              :href => url_for(:controller => "cart",
              :action => "add", :id => book)}
            end
            
   def remove_book_link(text, book)
     link_to_remote text, {:url => {:controller => "cart",
              :action => "remove", 
              :id => book}},
            {:title => "Remove book",
              :href => url_for( :controller => "cart",
              :action => "remove", :id => book)}
            end
  def clear_cart_link (text = "Clear Cart")
  link_to_remote text,
  {:url => {:controller => "cart",
              :action => "clear"}},
            {:href => url_for( :controller => "cart",
              :action => "clear")}
  
  end

 #def display_tags(book)
   #@tags = Book.tag_counts[0,20]
   #@tags = Book.tag_counts[0,20]
 #end

def tag_cloud(tag_counts)
  ceiling = Math.log(tag_counts.max { |a,b| a.count <=> b.count }.count)
  floor = Math.log(tag_counts.min { |a,b| a.count <=> b.count }.count)
  range = ceiling - floor
    
  tag_counts.each do |tag|
  count = tag.count
  size = (((Math.log(count) - floor)/range)*66)+33
  yield tag, size
  end
end


     
end
