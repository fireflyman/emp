class CatalogController < ApplicationController
  before_filter :initialize_cart

  def index
    @page_title = "Book List"
    @books =Book.paginate :page =>params[:page], 
                                     :order => :id,
                                     :per_page => 10
                                     #:include => [:authors, :publisher],
                                     
   end

  def show
    @book = Book.find(params[:id]) rescue nil
    return render( :text => "Not found", :status => 404) unless @book
    @page_title = @book.title
  end



 def search
    @page_title = "Search"
    if params[:commit] == "Search" || params[:q]
      @books = Book.find_with_ferret(params[:q].to_s.upcase)
      unless @books.size > 0
        flash.now[:notice] = "No book found matching your criteria"
      end
    end
  end
 

  def latest
    @page_title = "Latest Books"
    @books = Book.latest
  end
  
  def rss
    latest
    render :layout => false
  end
  
   def checkout
   #@cart = find_cart
       @order = Order.new
     end
     
   def save_order
    # @cart = find_cart
     @order = Order.new(params[:order])
    # @order.add_line_items_from_cart(@cart)
   if @order.save
       session[:cart] = nil
       redirect_to_index("Thank you for your order")
   else
       render :action => 'checkout'
   end
  
 end

private
  
  def find_cart
    @cart=(session[:cart]  ||= Cart.new)
  end
  
  def redirect_to_index(msg = nil)
      flash[:notice] = msg if msg
      redirect_to :action => 'index'
    end
    
end
