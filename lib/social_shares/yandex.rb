module SocialShares
  class Yandex < Base
    URL = 'http://wow.ya.ru/ajax/share-counter.xml'

    def shares!
      response = RestClient.get(URL, params: { url: checked_url })

      /(\d+)/.match(response)[-1].to_i
    end
  end
end
