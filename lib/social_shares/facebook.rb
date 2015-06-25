module SocialShares
  # Do not use graph API because it returns sum of
  # real shares + likes + number of comments in one number
  # instead of just shares.
  #
  # You can compare it by yourself:
  # https://graph.facebook.com/?id=http://www.apple.com/
  # {
  #   id: "http://www.apple.com/",
  #   shares: 586427,   # <--- sum of real shares + likes + number of comments
  #   comments: 11
  # }
  #
  # http://api.ak.facebook.com/restserver.php?urls=http://www.apple.com/&v=1.0&method=links.getStats&format=json
  # [
  #   {
  #     url: "http://www.apple.com/",
  #     normalized_url: "http://www.apple.com/",
  #     share_count: 253112,  # <--- just shares
  #     like_count: 241956,
  #     comment_count: 91359,
  #     total_count: 586427,
  #     click_count: 0,
  #     comments_fbid: "388265801869",
  #     commentsbox_count: 11
  #   }
  # ]

  class Facebook < Base
    URL = 'http://api.ak.facebook.com/restserver.php'

    def shares!
      response = RestClient.get(URL, {
        :params => {
          :urls => checked_url,
          :v => '1.0',
          :method => 'links.getStats',
          :format => 'json'
        }
      })
      JSON.parse(response)[0]['share_count'] || 0
    end
  end
end
