module SocialShares
  class Linkedin < Base
    URL = 'http://www.linkedin.com/countserv/count/share'

    def shares!
      response = get(URL, {
                    :params => {
                      :url => checked_url,
                      :format => 'json'
                    }
                  })
      JSON.parse(response)['count']
    rescue
      0
    end
  end
end
