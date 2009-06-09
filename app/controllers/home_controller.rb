class HomeController < ApplicationController
  def index
    
    @mykurls = []
    
    tokens = Mykurl.read_cookies(cookies)
    
    #flash[:notice] = @the_coockies
          tokens.each do |token|
      
                @tmp_url = Mykurl.find_by_token(token);
                
                unless @tmp_url.nil?
                  @mykurls << @tmp_url
                end
    
           end
    
    
    @mykurl = Mykurl.new
  end
  
end
