module SocialShares
  class Facebook < Base
    def shares!
      response = RestClient.get url, {
        :params => {
          :urls => checked_url,
          :v => '1.0',
          :method => 'links.getStats',
          :format => 'json'
        }
      }
      JSON.parse(response)[0]["total_count"] || 0
    end

  private

    def url
      "http://api.ak.facebook.com/restserver.php"
    end
  end
end
