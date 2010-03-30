class CatalogController < ApplicationController

  def index
    @page_title = "Book List"
    @books =Book.paginate :page =>params[:page], 
                                     :per_page => 10,
                                     :include => [:authors, :publisher],
                                     :order => id
   end

  def show
    @book = Book.find(params[:id] rescue nil)
    return render( :text => "Not found", :status => 404)
    unless @book
    @page_title = @book.title
  end

  def search
  end

  def lastest
  end
end
