class ZipcodeReturner

  include HTTParty

  base_uri 'https://www.zipcodeapi.com/rest'

  @@token = ENV['ZIPCODE_API_KEY']

  def self.closest_zipcodes(zipcode)
    result = self.get("/#{@@token}/radius.json/#{zipcode}/50/mile")
    result_arr = result["zip_codes"]
    parsed_zipcodes_arr(result_arr)
  end

  def self.parsed_zipcodes_arr(result_arr)
    result_arr.map { |city| city["zip_code"] }
  end

end
