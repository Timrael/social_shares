module SocialShares
  class Base < Struct.new(:checked_url)
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
