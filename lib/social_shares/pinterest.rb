module SocialShares
  class Pinterest < Base
    def shares!
      response = RestClient.get url, {:params => {:url => checked_url}}
      /count":(\d+)/.match(response)[-1].to_i
    end

    private

    def url
      "http://api.pinterest.com/v1/urls/count.json"
    end
  end
end
