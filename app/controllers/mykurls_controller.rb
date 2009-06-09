class MykurlsController < ApplicationController

   #when clicking on a shorturl you end up here - 
  #this is where we direct you to the right challenge  
  #or to a failure message - selling something?
  def mykurl
    

  end
  

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
    @mykurl = Mykurl.find_by_token(params[:id])

         
    if @mykurl.nil?
            flash[:notice]  = "The url was not found ... " 
            redirect_to root_path
    else
            @mykurl.update_data(request)
            redirect_to @mykurl.url
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

  # POST /mykurls.
  # POST /mykurls.xml
  def create
    @mykurl = Mykurl.new(params[:mykurl])
    @mykurl.token = Mykurl.generate_token
    respond_to do |format|
      if @mykurl.save
        #create a coockie if user not logged in, save for 2 weeks
        unless current_user
            if cookies[:mykurls].blank?
              cookies[:mykurls] = { :value => @mykurl.token, :expires => Time.now + ((3600*24)*7*2)}
            else
              Mykurl.write_cookies(cookies, @mykurl.token)
            end
            
        end
        
        flash[:notice] = 'Url was successfully shortened.'
        format.html { redirect_to(@mykurl) }
        format.js { return :text => "Url shortened"  }
        format.xml  { render :xml => @mykurl, :status => :created, :location => @mykurl }
      else
        flash[:notice] = 'Mykurl was NOT successfully created.'
        @mykurl = nil
        format.html { render :action => "new" }
        format.js { return :text => "Url was not shortened"  }
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
