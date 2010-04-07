require File.dirname(__FILE__) + '/../test_helper'

class CartControllerTest < ActionController::TestCase
  fixtures :authors, :publishers, :books, :authors_books
  assert_difference(CartItem, :count) do
  post :add, :id => 4
 end
 
 assert_response :redirect
 assert_redirected_to :controller => "caralog"
 assert_equal 1, Cart.find(@request.session[:cart_id]).cart_items.size


end
