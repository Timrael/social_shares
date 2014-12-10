module SocialShares
  class Linkedin < Base
    def shares!
      response = RestClient.get url, {
        :params => {
          :url => checked_url,
          :format => 'json'
        }
      }
      JSON.parse(response)['count']
    end

    private

    def url
      "http://www.linkedin.com/countserv/count/share"
    end
  end
end
