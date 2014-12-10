module SocialShares
  class Reddit < Base
    def shares!
      response = RestClient.get url, {:params => {:url => checked_url}}
      children_data = JSON.parse(response)['data']['children']
      children_data.map{|c| c['data']['score']}.reduce(:+) || 0
    end

    private

    def url
      "http://www.reddit.com/api/info.json"
    end
  end
end
