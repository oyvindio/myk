class MykurlsController < ApplicationController
  # GET /mykurls
  # GET /mykurls.xml
  def index
    @mykurls = Mykurl.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mykurls }
    end
  end

  # GET /mykurls/1
  # GET /mykurls/1.xml
  def show
    @mykurl = Mykurl.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mykurl }
    end
  end

  # GET /mykurls/new
  # GET /mykurls/new.xml
  def new
    @mykurl = Mykurl.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mykurl }
    end
  end

  # GET /mykurls/1/edit
  def edit
    @mykurl = Mykurl.find(params[:id])
  end

  # POST /mykurls
  # POST /mykurls.xml
  def create
    @mykurl = Mykurl.new(params[:mykurl])

    respond_to do |format|
      if @mykurl.save
        flash[:notice] = 'Mykurl was successfully created.'
        format.html { redirect_to(@mykurl) }
        format.xml  { render :xml => @mykurl, :status => :created, :location => @mykurl }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mykurl.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /mykurls/1
  # PUT /mykurls/1.xml
  def update
    @mykurl = Mykurl.find(params[:id])

    respond_to do |format|
      if @mykurl.update_attributes(params[:mykurl])
        flash[:notice] = 'Mykurl was successfully updated.'
        format.html { redirect_to(@mykurl) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mykurl.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mykurls/1
  # DELETE /mykurls/1.xml
  def destroy
    @mykurl = Mykurl.find(params[:id])
    @mykurl.destroy

    respond_to do |format|
      format.html { redirect_to(mykurls_url) }
      format.xml  { head :ok }
    end
  end
end
