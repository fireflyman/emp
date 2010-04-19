class TagController < ApplicationController

  def index
    @page_title = 'Listing tags'
    @tags = Book.tag_counts
    @tags =Tag.paginate :page=>params[:page],
                                  :order => :name,
                                  :per_page => 10
  end

  def show
    #@page_title = Book tagged with "#{tag}"
     @books= Book.find_tagged_with(params[:id])
     
  end
end
