require 'rest-client'
require 'oj'
require 'social_shares/version'
require 'social_shares/base'
require 'social_shares/facebook'
require 'social_shares/google'
require 'social_shares/twitter'
require 'social_shares/vkontakte'

module SocialShares
  class << self
    SUPPORTED_NETWORKS = [:vkontakte, :facebook, :google, :twitter]

    def supported_networks
      SUPPORTED_NETWORKS
    end

    SUPPORTED_NETWORKS.each do |network_name|
      define_method(network_name) do |url|
        Object.const_get("#{self.name}::#{network_name.to_s.capitalize}").new(url).shares
      end
    end

    def selected(url, selected_networks)
      filtered_networks(selected_networks).inject({}) do |result, network_name|
        result[network_name] = self.send(network_name, url)
        result
      end
    end

    def all(url)
      selected(url, SUPPORTED_NETWORKS)
    end

    def total(url, selected_networks = SUPPORTED_NETWORKS)
      selected(url, selected_networks).values.reduce(:+)
    end

    def has_any?(url, selected_networks = SUPPORTED_NETWORKS)
      !filtered_networks(selected_networks).find{|n| self.send(n, url) > 0}.nil?
    end

  private

    def filtered_networks(selected_networks)
      selected_networks.map(&:to_sym) & SUPPORTED_NETWORKS
    end
  end
end
