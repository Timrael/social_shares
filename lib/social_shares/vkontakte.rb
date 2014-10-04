module SocialShares
  class Vkontakte < Base
    def shares
      response = RestClient.get(url)
      /VK.Share.count\(1,\s(\d+)\)/.match(response)[1].to_i
    end

  private

    def url
      "http://vk.com/share.php?act=count&index=1&url=#{checked_url}"
    end
  end
end
