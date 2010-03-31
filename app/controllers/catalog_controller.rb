class CatalogController < ApplicationController

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
 

  def lastest
    @page_title = "Latest Books"
    @books = Book.latest
  end
end
