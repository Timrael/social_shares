module SocialShares
  class Base
    TIMEOUT = OPEN_TIMEOUT = 3
    attr_accessor :checked_url

    def initialize(checked_url)
      # remove URI fragment
      @checked_url = checked_url.gsub(/#.+$/, '')
    end

    def shares
      shares!
    rescue => e
      puts "[#{self.class.name}] Error during requesting sharings of '#{checked_url}': #{e}"
      nil
    end

    def get(url, params)
      RestClient::Resource.new(url, timeout: TIMEOUT, open_timeout: OPEN_TIMEOUT).get(params)
    end

    def post(url, params, headers = {})
      RestClient::Resource.new(url, timeout: TIMEOUT, open_timeout: OPEN_TIMEOUT).post(params, headers)
    end

    def shares!
      raise NotImplementedError
    end
  end
end
