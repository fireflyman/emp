class CartController < ApplicationController

  before_filter :initialize_cart
  
  def add
    params[:id].gsub!(/book_/, "")
   @book = Book.find(params[:id])
   if request.xhr?
     @item = @cart.add(params[:id])
     flash.now[:cart_notice] =  "Added <em>#{@item.book.title}</em>"
     render :action => "add_with_ajax"
   elsif request.post?
    @item = @cart.add(params[:id])
    flash[:cart_notice] = "Added <em>#{@item.book.title}</em>"
    redirect_to session[:return_to] || :controller => "catalog"
    else
      render
   end
  end
  
  
 
   
  def remove
   @book = Book.find(params[:id])
   if request.xhr?
     @item = @cart.remove(params[:id])
     flash.now[:cart_notice] =  "Remove 1 <em>#{@item.book.title}</em>"
     render :action => "remove_with_ajax"
   elsif request.post?
    @item = @cart.remove(params[:id])
    flash[:cart_notice] = "Remove 1 <em>#{@item.book.title}</em>"
    redirect_to :controller => "catalog"
    else
      render
   end
  end
  
    
  def clear
   if request.xhr?
     @cart.cart_items.destroy_all
     flash.now[:cart_notice] =  "Clear the cart"
     render :action => "clear_with_ajax"
   elsif request.post?
    @cart.cart_items.destroy_all
     flash.now[:cart_notice] =  "Clear thr cart"
     redirect_to :controller => "catalog"
    else
      render
   end
  end



end
