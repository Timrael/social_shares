module SocialShares
  class Base
    attr_accessor :checked_url

    def initialize(checked_url)
      @checked_url = checked_url
    end

    def shares
      raise NotImplementedError
    end
  end
end
