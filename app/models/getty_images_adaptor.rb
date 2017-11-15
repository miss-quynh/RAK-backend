class GettyImagesAdaptor

  include HTTParty

  base_uri 'https://api.gettyimages.com/v3/'
  @@token = ENV['GETTY_IMAGES_API_KEY']

  headers        Authorization: "Bearer #{@@token}"

  def self.return_image(query)
    response = self.get("/search/images?fields=id,title,thumb,referral_destinations&sort_order=best&phrase=#{query}&")
    return parse_data(response)
  end

  def self.parse_data(response)
    response["images"][0]["display_sizes"]["uri"]
  end

end