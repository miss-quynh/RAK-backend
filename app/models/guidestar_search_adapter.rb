class GuidestarSearchAdapter

  include HTTParty

  base_uri "https://Sandboxdata.guidestar.org/v1_1/search?"
  format :json

  @@auth = {:username => ENV['GUIDESTAR_USERNAME'], :password => ENV['GUIDESTAR_PASSWORD']}

  def self.verify_organization(ein)
    response = self.get('', query: { q: "ein:#{ein}" }, basic_auth: @@auth )
    return parse_data(response)
  end

  private

  def self.parse_data(response)
    JSON.parse(response.body)
    return response["hits"]
    rescue
    false
  end
end
