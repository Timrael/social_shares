module SocialShares
  class Vkontakte < Base
    URL = 'http://vk.com/share.php'

    def shares!
      response = get(URL, {
        params: {
          act: 'count',
          index: 1,
          url: checked_url
        }
      })

      /VK.Share.count\(1,\s(\d+)\)/.match(response)[1].to_i
    end
  end
end
