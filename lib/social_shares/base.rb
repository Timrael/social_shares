module SocialShares
  class Base
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
  end
end
