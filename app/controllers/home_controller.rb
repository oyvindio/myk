class HomeController < ApplicationController
  def index
    
    @mykurl = Mykurl.find_by_token(params[:id])
    
    flash[:notice] = @mykurl
         
            if @mykurl.nil?
                    @mykurls = []
    
                    tokens = Mykurl.read_cookies(cookies)
    
                    tokens.each do |token|
                
                          @tmp_url = Mykurl.find_by_token(token);
                          
                          unless @tmp_url.nil?
                            @mykurls << @tmp_url
                          end
              
                     end
    
                     @mykurls = @mykurls.reverse
                     @mykurl = Mykurl.new
 
                    
            else
                    @mykurl.update_data(request)
                    redirect_to @mykurl.url
            end

   end
  
  def cron
    return render :text => "cron"
  end

  def show_map
  
    @url=Mykurl.find_by_token(params[:token])
    @map = GoogleMap.new
    for location in @url.locations do
    
        unless location.lng.nil? || location.lng==0 ||  location.lat==0|| location.lat.nil?
        

        @map.markers << GoogleMapMarker.new(:map => @map, 
                                     :lat => location.lat, 
                                     :lng => location.lng,
                                     :html=> ""
                                     )
         end
       end
                                         
  end    
end
