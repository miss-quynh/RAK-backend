class GettyImagesAdaptor

  include HTTParty

  base_uri 'https://api.gettyimages.com/v3/search/images'

  @@token = ENV['GETTY_IMAGES_API_KEY']

  headers        "Api-Key": @@token

  default_params fields: "id,title,thumb,referral_destinations",
                 sort_order: "best"

  def self.return_image(phrase)
    response = self.get("", query: {phrase: phrase})
    return parse_data(response)
  end

  def self.parse_data(response)
    response["images"][0]["display_sizes"][0]["uri"]
  end

end