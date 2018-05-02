module SocialShares
  class Stumbleupon < Base
    URL = 'http://www.stumbleupon.com/services/1.01/badge.getinfo'

    def shares!
      response = get(URL, params: { url: checked_url })
      JSON.parse(response).dig('result', 'views').to_i
    end
  end
end
