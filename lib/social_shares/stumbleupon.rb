module SocialShares
  class Stumbleupon < Base
    def shares!
      response = RestClient.get(url)
      JSON.parse(response)['result']['views'] || 0
    end

    private

    def url
      "http://www.stumbleupon.com/services/1.01/badge.getinfo?url=#{checked_url}"
    end
  end
end
