require File.dirname(__FILE__) + '/../test_helper'

class AuthorTest < ActiveSupport::TestCase
  fixtures :authors
  # Replace this with your real tests.
 def test_name
  author = Author.create(:first_name => 'Joel',
                                   :last_name => 'Spolsky')
  assert_equal 'Joel Spolsky', author.name
 end
 
end
