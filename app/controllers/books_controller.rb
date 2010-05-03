class BooksController < ApplicationController
  # GET /books
  # GET /books.xml
  before_filter :authorize, :expect => :login
    uses_tiny_mce( :options => {
      :theme => 'advanced',  # �ֽ�
      :language => 'zh',  # ����ɭ�
      :convert_urls => false, # ���ഫ���|�A�_�h�b���J�Ϥ��Ή`���ɡA�N�ন�۹���|�A�e���ɭP���|����
      :theme_advanced_toolbar_location => "top",  # �u���b�W��
      :theme_advanced_toolbar_align => "left",
      :theme_advanced_resizing => true,  # ���G���n��
      :theme_advanced_resize_horizontal => false,
      :paste_auto_cleanup_on_paste => true,
      # �u���W����?����
      :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect forecolor backcolor bold italic underline strikethrough sub sup removeformat},
      :theme_advanced_buttons2 => %w{undo redo cut copy paste separator justifyleft justifycenter justifyright separator indent outdent separator bullist numlist separator link unlink image media emotions separator table separator fullscreen},
      :theme_advanced_buttons3 => [],
      # �r�^�C��?�ܪ��r�^
      :theme_advanced_fonts => %w{���^=���^;���^=���^;�駺=�駺;���^=���^;�Į�=�Į�;����=����;Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats}, # �r�^
      # :force_br_newlines => true, # ��??�L��??��?�q���ŏ�(P)��?��?���(BR)�C����?�ΡGff�U���n�ϡA�ΤF��??�Z�A�]�J?�e���~���B�M?��?�����Q�}���C
      :plugins => %w{contextmenu paste media emotions table fullscreen inlinepopups}},
    :only => [:new, :edit, :show, :index, :create, :update])  # tiny_mce��?���D�`?�ߡA?���O���w����action���_��

  
  def index
    @page_title ='Listing books' 
    #@book_tag_count = Book.tag_counts()
    @book = Book.tag_counts()

    #@books = Book.find(:all)
    #tag_cloud
    #tag
    sort_by = params[:sort_by]
    @books =Book.paginate :page =>params[:page], 
                                     :order => sort_by, 
                                     :per_page => 10
   
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @books }
    end
  end

  # GET /books/1
  # GET /books/1.xml
  def show
    @book = Book.find(params[:id])
    @page_title = "#{@book.title}"
    @books = Book.tag_counts()
    # tag
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/new
  # GET /books/new.xml
  def new
    load_data
    @book = Book.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @book }
    end
  end

  # GET /books/1/edit
  def edit
    @page_title = 'Editing book'
    load_data
    @book = Book.find(params[:id])
    
  end

  # POST /books
  # POST /books.xml
  def create
    @book = Book.new(params[:book])
    #@book.tag_list = params[:tags]

    respond_to do |format|
      if @book.save
        flash[:notice] = 'Book was successfully created.'
        format.html { redirect_to(@book) }
        format.xml  { render :xml => @book, :status => :created, :location => @book }
      else
        load_data
        format.html { render :action => "new" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /books/1
  # PUT /books/1.xml
  def update
    
    @book = Book.find(params[:id])
    #@book.tag_list = params[:tags]

    respond_to do |format|
      if @book.update_attributes(params[:book])
        flash[:notice] = 'Book was successfully updated.'
        format.html { redirect_to(@book) }
        format.xml  { head :ok }
      else
        load_data
        format.html { render :action => "edit" }
        format.xml  { render :xml => @book.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.xml
  def destroy
    @book = Book.find(params[:id])
    @book.destroy

    respond_to do |format|
      format.html { redirect_to(books_url) }
      format.xml  { head :ok }
    end
  end
  
  
#tag method
=begin
   def tag_cloud
        @tags = Book.tag_counts
   end

   def tag
       @books= Book.find_tagged_with(params[:id])
     end
=end
     def tag
       @books = Book.find_tagged_with(params[:id])
     end
     
     def show_tag
       #@books = Book.find_tagged_with(params[:id])
       @tags = Book.tag_counts
       #@book = Book.tag_counts
      #render :template => "books/show"
      
      #render :template => "catalog/index"
     end
  
  def add_tag
    @lemma.tag_list.add params[:tag]
    @lemma.save_tags
    id = dom_id(@lemma) + "_tags"
    render :update do |page|
      page.replace_html id, tag_cloud(@lemma.tag_counts)
      page << %{
         new Effect.Highlight('#{id}',{startcolor:'#80FF00',duration: 3.0 });
      }
    end
  end
 
  def remove_tag
    @lemma.tag_list.remove params[:tag]
    @lemma.save_tags
    id = dom_id(@lemma) + "_tags"
    render :update do |page|
      page.replace_html id, tag_cloud(@lemma.tag_counts)
      page << %{
         new Effect.Highlight('#{id}',{startcolor:'#80FF00',duration: 3.0 });
      }
    end
  end


 
  private
  
  def load_data
    @authors = Author.find(:all)
    @publishers = Publisher.find(:all)
    #@tags = Tag.find(:all)
  end
  

   

  
  
end
