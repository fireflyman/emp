require "#{File.dirname(__FILE__)}/../test_helper"

class BrowsingAndSearchingTest < ActionController::IntegrationTest
 fixtures :publishers, :authors, :books, :authors_books
 
 def test_browsing_the_site
  jill = enter_site(:jill)
  jill.browse_index
end

private

 module BrowsingTestDSL
  attr_writer :name

def browse_index
 get "/catalog/index"
 
 assert_response :success
 assert_template "catalog/index"
 assert_tag   :tag => "dl", :attributes => 
                    { :id => "books" },
                    :children => 
                     { :count => 10 , :only =>
                        { :tag => "dt"}}
 assert_tag :tag => "dt", :content => "The Idiot"
 end
end
 
 def enter_site(name)
  open_session do |session|
   session.extend(BrowsingTestDSL)
   session.name = name
   yield session if block_given?
  end
  
 end
 

end
