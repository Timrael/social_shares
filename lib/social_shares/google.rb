module SocialShares
  class Google < Base
    URL = 'https://clients6.google.com/rpc?key=AIzaSyCKSbrvQasunBoV16zDH9R33D88CeLr9gQ'

    def shares!
      response = post(URL, JSON.dump(params), { content_type: :json, accept: :json })

      JSON.parse(response)[0]['result']['metadata']['globalCounts']['count'].to_i
    end

  private

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
