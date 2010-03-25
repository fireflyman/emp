require File.dirname(__FILE__) + '/../test_helper'
require 'publishers_controller'

class PublishersController
 def rescue_action(e)
  raise e
 end
end

class PublishersControllerTest < ActionController::TestCase
  fixtures :publishers
   def setup
   @controller = PublishersController.new
   @request = ActionController::TestRequest.new
   @response = ActionController::TestResponse.new
 end
 def test_create
  num_publishers = Publisher.count
  
  post :create, :publisher => {:name => 'The Monopoly Publishing Company'}
  
  assert_response :redirect
  assert_redirected_to :action => 'show'
  
  assert_equal num_publishers + 1, Publisher.count
 end
 
 def test_show
  get :show, :id => 1
  
  assert_response :success
  assert_template 'publishers/show'
  
  assert_not_nil assigns(:publisher)
  assert assigns(:publisher).valid?
  
  assert_tag "h1", :content => Publisher.find(1).name
end

def test_update
 post :update, :id => 1, :publisher => { :name => 'Apress.com'}
 assert_response :redirect
 assert_redirected_to :action => 'show', :id => 1
 assert_equal 'Apress.com', Publisher.find(1).name
end

 
=begin
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:publishers)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_publisher
    assert_difference('Publisher.count') do
      post :create, :publisher => { }
    end

    assert_redirected_to publisher_path(assigns(:publisher))
  end

  def test_should_show_publisher
    get :show, :id => publishers(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => publishers(:one).id
    assert_response :success
  end

  def test_should_update_publisher
    put :update, :id => publishers(:one).id, :publisher => { }
    assert_redirected_to publisher_path(assigns(:publisher))
  end

  def test_should_destroy_publisher
    assert_difference('Publisher.count', -1) do
      delete :destroy, :id => publishers(:one).id
    end

    assert_redirected_to publishers_path
  end
=end
end
