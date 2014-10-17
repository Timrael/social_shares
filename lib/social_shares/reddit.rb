module SocialShares
  class Reddit < Base
    def shares
      response = RestClient.get(url)
      children_data = JSON.parse(response)['data']['children']
      children_data.map{|c| c['data']['score']}.reduce(:+)
    end

    private

    def url
      "http://www.reddit.com/api/info.json?url=#{checked_url}"
    end
  end
end
