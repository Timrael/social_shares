module SocialShares
  class Reddit < Base
    URL = 'http://www.reddit.com/api/info.json'

    def shares!
      response = get(URL, params: { url: checked_url })

      children_data = JSON.parse(response)['data']['children']
      children_data.map { |c| c['data']['score'] }.reduce(:+) || 0
    end
  end
end
