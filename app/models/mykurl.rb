class Mykurl < ActiveRecord::Base
  validates_presence_of :url
  
  default_scope :order=>"created_at DESC"

  #generates a hash of 5 strings until it finds one that is not taken
  def self.generate_token
    @token = Digest::SHA1.hexdigest(Time.now.to_s)[0..4]
    while (!available(@token)) do
      @token = Digest::SHA1.hexdigest(Time.now.to_s)[0..4]
    end 
    return @token
  end
  
  #checks to see if the hash it not allready taken
  def self.available(token)
    if Mykurl.find_by_token(token).nil?
      return true
    else
      return false
    end
  end

  def update_data(request)
    self.clicks+=1
    self.save
    #Location.create_from_shorturl(self,request)    
  end
end
