module SocialShares
  class MailRu < Base
    def shares!
      response["share_mm"].to_i
    end

  protected

    def response
      response = RestClient.get(url)
      JSON.parse(response)
    end

    def url
      "http://appsmail.ru/share/count/#{checked_url}"
    end
  end
end
