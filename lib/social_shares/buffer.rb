module SocialShares
  class Buffer < Base
    def shares!
      response = RestClient.get url, {:params => {:url => checked_url}}
      JSON.parse(response)['shares']
    end

  private

    def url
      "https://api.bufferapp.com/1/links/shares.json"
    end
  end
end
