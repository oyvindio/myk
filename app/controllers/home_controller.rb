class HomeController < ApplicationController
  def index
    @mykurls = []
    
    
          cookies[:mykurls].each do |cookie|
      
                @tmp_url = Mykurl.find_by_token(cookie[:value]);
                
                unless @tmp_url.nil?
                  @mykurls << @tmp_url
                end
    
           end
    
    
    @mykurl = Mykurl.new
  end
  
end
