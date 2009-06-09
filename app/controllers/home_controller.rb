class HomeController < ApplicationController
  def index
    @mykurl = Mykurl.new
  end
  
end
