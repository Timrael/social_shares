module SocialShares
  class Weibo < Base
    def shares!
      response = RestClient.get(url_for_share)
      JSON.parse(response)['urls'].first['share_counts'].to_i
    end

  private

    def url_for_short
      "https://api.weibo.com/2/short_url/shorten.json?_=1414437609673&source=8003029170&url_long=#{checked_url}"
    end

    def short_url
      response = RestClient.get(url_for_short)
      JSON.parse(response)['urls'].first['url_short']
    end

    def url_for_share
      "https://api.weibo.com/2/short_url/share/counts.json?_=1414437609900&source=8003029170&url_short=#{short_url}"
    end
  end
end
