class Mykurl < ActiveRecord::Base
  validates_presence_of :url
  has_many :locations  
  

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
  
  def self.write_cookies(cookie_box,token)
    cookie_box[:mykurls] = {:value => cookie_box[:mykurls].to_s.split(',').push(token.to_s).join(','), :expires => Time.now + ((3600*24)*7*2*2)}
  end

  def self.read_cookies(cookie_box)
    cookie_box[:mykurls].to_s.split(',')
  end
  
   #used to prevent passenger to fall asleep. crontab calls this every 9 minutes
   def self.wake_up
      return 0
   end
  
end
