module SocialShares
  class Odnoklassniki < Base
    URL = 'http://ok.ru/dk'

    def shares!
      response = RestClient.get(URL, {
        params: {
          'st.cmd' => 'extLike',
          uid: 'odklcnt0',
          ref: checked_url
        }
      })

      /'(\d+)'\)/.match(response)[-1].to_i
    end
  end
end
