
class Location < ActiveRecord::Base
  belongs_to :mykurl

def self.create_from_shorturl(shorturl, request)
    geo = GeoData::IpConverter.new()
    location = geo.convert(request.remote_ip)    
    
    new_location = Location.create!(:mykurl_id=>shorturl.id)
    unless new_location.lat==0&&new_location.lng==0    
        new_location.lat        =   location[:latitude] rescue nil
        new_location.lng        =   location[:longitude] rescue nil
        new_location.country    =   location[:country] rescue nil
        new_location.city       =   location[:city] rescue nil
        new_location.ip         =   request.remote_ip rescue nil
        new_location.domain =   request.referrer
        new_location.save
    end
    
    if request.referrer.include? 'facebook'
      new_location.mykurl.facebook_count+=1
      new_location.mykurl.save
    end
    
    if request.env['REMOTE_ADDR'].to_s=='88.87.53.83'
      new_location.mykurl.twitter_count+=1
      new_location.mykurl.save
    end
  end


end
