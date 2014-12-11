module SocialShares
  class Facebook < Base
    URL = 'http://api.ak.facebook.com/restserver.php'

    def shares!
      response = RestClient.get(URL, {
        :params => {
          :urls => checked_url,
          :v => '1.0',
          :method => 'links.getStats',
          :format => 'json'
        }
      })
      JSON.parse(response)[0]["share_count"] || 0
    end
  end
end
