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
    
    
                     @mykurl = Mykurl.new
 
                    
            else
                    @mykurl.update_data(request)
                    redirect_to @mykurl.url
            end

   end
  
end
