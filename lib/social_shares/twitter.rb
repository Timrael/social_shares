module SocialShares
  class Twitter < Base
    URL = 'http://public.newsharecounts.com/count.json'

    def shares!
      response = get(URL, params: { url: checked_url })

      JSON.parse(response)['count']
    end
  end
end
