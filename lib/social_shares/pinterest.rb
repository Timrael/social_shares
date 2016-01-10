module SocialShares
  class Pinterest < Base
    URL = 'http://api.pinterest.com/v1/urls/count.json'

    def shares!
      response = get(URL, params: { url: checked_url })

      /count":(\d+)/.match(response)[-1].to_i
    end
  end
end
