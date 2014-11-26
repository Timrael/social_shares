module SocialShares
  class Facebook < Base
    def shares!
      response = RestClient.get url, {:params => {:id => checked_url}}
      JSON.parse(response)["shares"] || 0
    end

  private

    def url
      "http://graph.facebook.com/"
    end
  end
end
