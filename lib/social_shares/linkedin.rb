module SocialShares
  class Linkedin < Base
    def shares
      response = RestClient.get(url)
      JSON.parse(response)['count']
    end

    private

    def url
      "http://www.linkedin.com/countserv/count/share?format=json&url=#{checked_url}"
    end
  end
end
