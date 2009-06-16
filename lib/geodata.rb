module GeoData
  class IpConverter
    def convert (incoming_ip)
    #ip = "123.123.123.123";
		ip = incoming_ip#request.remote_ip
		ips = ip.to_s
		url = "http://iplocationtools.com/ip_query.php?ip="+ips

		xml_data = Net::HTTP.get_response(URI.parse(url)).body

    xmldoc = REXML::Document.new(xml_data)

		# Now get the root element
		root = xmldoc.root
		city = ""
		regionName = ""
		countryName = ""
    latitude=""
    longitude=""
    
		# This will take country name...
		xmldoc.elements.each("Response/CountryName") {
		|e| countryName << e.text rescue nil
	    }

    # This will take longitude...
		xmldoc.elements.each("Response/Longitude") {
		|e| longitude << e.text rescue nil
	    }

    # This will take latitude...
		xmldoc.elements.each("Response/Latitude") {
		|e| latitude << e.text rescue nil
	    }

		# Now get city name...
		xmldoc.elements.each("Response/City") {
   		|e| city << e.text rescue nil
	    }

		# This will take regionName...
		xmldoc.elements.each("Response/RegionName") {
   		|e| regionName << e.text rescue nil
	    }

     	ipLocation = {:city=> city, 
     	              :region=> regionName, 
     	              :country => countryName,
     	              :latitude=>latitude,
     	              :longitude=>longitude}

	 return ipLocation
  end
  end
end
