class ZipcodeReturner

  include HTTParty

  base_uri 'https://www.zipcodeapi.com/rest'

  @@token = ENV['ZIPCODE_API_KEY']

  def self.closest_zipcodes(zipcode)
    result = self.get("/#{@@token}/radius.json/#{zipcode}/50/mile")
    closest_zipcodes_arr(result)
  end

  def closest_zipcodes_arr(result)
    result["zip_codes"]
  end

end