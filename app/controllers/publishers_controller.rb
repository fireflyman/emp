class PublishersController < ApplicationController
  # GET /publishers
  # GET /publishers.xml
    before_filter :authorize, :expect => :login
  def index
    @publishers = Publisher.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @publishers }
    end
  end

  # GET /publishers/1
  # GET /publishers/1.xml
  def show
    @publisher = Publisher.find(params[:id])
    @page_title = @publisher.name

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publisher }
    end
  end
=begin  
   def show
    @publisher = Publisher.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @publisher }
    end
  end
=end
  # GET /publishers/new
  # GET /publishers/new.xml
  def new
    @publisher = Publisher.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @publisher }
    end
  end

  # GET /publishers/1/edit
  def edit
    @publisher = Publisher.find(params[:id])
  end

  # POST /publishers
  # POST /publishers.xml
  def create
    @publisher = Publisher.new(params[:publisher])

    respond_to do |format|
      if @publisher.save
        flash[:notice] = 'Publisher was successfully created.'
        format.html { redirect_to(@publisher) }
        format.xml  { render :xml => @publisher, :status => :created, :location => @publisher }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @publisher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /publishers/1
  # PUT /publishers/1.xml
  def update
    @publisher = Publisher.find(params[:id])

    respond_to do |format|
      if @publisher.update_attributes(params[:publisher])
        flash[:notice] = 'Publisher was successfully updated.'
        format.html { redirect_to(@publisher) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @publisher.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /publishers/1
  # DELETE /publishers/1.xml
  def destroy
    @publisher = Publisher.find(params[:id])
    @publisher.destroy
    #redirect_to :action => 'index'

    respond_to do |format|
      format.html { redirect_to(publishers_url) }
      format.xml  { head :ok }
    end

  end
end
