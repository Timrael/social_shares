module SocialShares
  class Hatebu < Base
    URL = 'http://api.b.st-hatena.com/entry.count'

    def shares!
      response = get(URL, params: {
        url: checked_url
      })
      # response.body.to_i returns status code instead of body converted to integer
      response.body.empty? ? 0 : response.body.to_f.to_i
    end
  end
end
