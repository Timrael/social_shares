module SocialShares
  class Weibo < Base
    URL_FOR_SHORT = 'https://api.weibo.com/2/short_url/shorten.json'
    URL_FOR_SHARE = 'https://api.weibo.com/2/short_url/share/counts.json'

    def shares!
      response = get(URL_FOR_SHARE, {
        params: {
          _: '1414437609900',
          source: '8003029170',
          url_short: short_url
        }
      })

      JSON.parse(response)['urls'].first['share_counts'].to_i
    end

  private

    def short_url
      response = get(URL_FOR_SHORT, {
                    :params => {
                      :_ => '1414437609673',
                      :source => '8003029170',
                      :url_long => checked_url
                    }
                  })
      JSON.parse(response)['urls'].first['url_short']
    end
  end
end
