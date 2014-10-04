module SocialShares
  class Google < Base
    def shares
      response = RestClient.post(url, Oj.dump(params), content_type: :json, accept: :json)
      Oj.load(response)[0]["result"]["metadata"]["globalCounts"]["count"].to_i
    end

  private

    def url
      "https://clients6.google.com/rpc?key=AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ"
    end

    def params
      [{
        'method' => 'pos.plusones.get',
        'id' => 'p',
        'jsonrpc' => '2.0',
        'key' => 'p',
        'apiVersion' => 'v1',
        'params' => {
          'nolog' => true,
          'id' => checked_url,
          'source' => 'widget',
          'userId' => '@viewer',
          'groupId' => '@self'
        }
      }]
    end
  end
end
