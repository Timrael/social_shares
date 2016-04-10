module SocialShares
  module StringHelper
    def to_underscore(str)
      str.dup.tap { |s| (s.gsub!(/(.)([A-Z])/,'\1_\2') || s).downcase! }
    end

    def to_camel_case(str)
      str.split('_').map(&:capitalize).join
    end
  end
end
