module SocialShares
  class Twitter < Base
    def shares!
      response = RestClient.get(url)
      JSON.parse(response)["count"]
    end

  private

    def url
      "http://cdn.api.twitter.com/1/urls/count.json?url=#{checked_url}"
    end
  end
end
