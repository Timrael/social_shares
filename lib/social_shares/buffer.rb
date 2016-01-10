module SocialShares
  class Buffer < Base
    URL = 'https://api.bufferapp.com/1/links/shares.json'

    def shares!
      response = get(URL, params: { url: checked_url })

      JSON.parse(response)['shares']
    end
  end
end
