module SocialShares
  class MailRu < Base
    URL = 'https://connect.mail.ru/share_count'

    def shares!
      response = get(URL, {
        params: {
          func: 'foo',
          callback: 1,
          url_list: checked_url
        }
      })

      matches = /shares":(\d+)/.match(response)
      matches ? matches[-1].to_i : 0
    end
  end
end
