module SocialShares
  class Base
    include SocialShares::StringHelper
    DEFAULT_TIMEOUT = 3
    DEFAULT_OPEN_TIMEOUT = 3

    @@config = {}

    class << self
      def config=(val)
        @@config = val
      end
    end

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

    def shares!
      raise NotImplementedError
    end

  protected

    def config_name
      to_underscore(self.class.name.split('::').last).to_sym
    end

    def timeout
      (@@config[config_name] || {})[:timeout] || DEFAULT_TIMEOUT
    end

    def open_timeout
      (@@config[config_name] || {})[:open_timeout] || DEFAULT_OPEN_TIMEOUT
    end

    def get(url, params)
      RestClient::Resource.new(url, timeout: timeout, open_timeout: open_timeout).get(params)
    end

    def post(url, params, headers = {})
      RestClient::Resource.new(url, timeout: timeout, open_timeout: open_timeout).post(params, headers)
    end
  end
end
