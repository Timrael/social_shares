module SocialShares
  class Buffer < Base
    def shares!
      response = RestClient.get(url)
      JSON.parse(response)['shares']
    end

  private

    def url
      "https://api.bufferapp.com/1/links/shares.json?url=#{checked_url}"
    end
  end
end
