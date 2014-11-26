module SocialShares
  class Twitter < Base
    def shares!
      response = RestClient.get url, {:params => {:url => checked_url}}
      JSON.parse(response)["count"]
    end

  private

    def url
      "http://cdn.api.twitter.com/1/urls/count.json"
    end
  end
end
