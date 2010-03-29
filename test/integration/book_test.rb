require "#{File.dirname(__FILE__)}/../test_helper"

class BookTest < ActionController::IntegrationTest
  # fixtures :your, :models
 fixtures :publishers, :authors
 def test_book_administration
  publisher = Publisher.create(:name => 'Books for Dummies')
  author = Author.create(:first_name => 'Bodo', :last_name => 'Bar')
  
  george = new_session_as(:george)
   george.add_book :book => {
     :title => 'Ruby for Dummie',
     :publisher_id => publisher.id,
     :author_ids => [author.id],
     :published_at => Time.now,
     :isbn => '123-123-123-X',
     :blurb => 'The best book released since "Eating for Dummies"',
     :page_count => 123,
     :price => 40.4
  }
end

private

module BookTestDSL
  attr_writer :name
  
  def add_book(parameters)
    author = Author.find(:all).first
    publisher = Publisher.find(:all).first
    
    get "/books/new"
    assert_response :success
    assert_template "books/new"
    
    assert_tag :tag => 'option', :attributes => { :value => publisher.id}
    assert_tag :tag => 'select', :attributes => {
        :id => 'book[author_ids][]'
    }
    
    
   post "/books/create", parameters
   assert_response :redirect
   #assert_redirected_to :action => 'index'
   #assert_response :error
   follow_redirect!
   assert_response :success
   assert_template "books/show"
   assert_tag :tag => 'td', :content => parameters[:book][:title]
   return Book.find_by_title(parameters[:book][:title])
  end
end
def new_session_as(name)
  open_session do |session|
   session.extend(BookTestDSL)
   session.name = name
   yield session if block_given?
  end
  
end

 
end
