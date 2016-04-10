require 'rest-client'
require 'json'
require 'social_shares/string_helper'
require 'social_shares/version'
require 'social_shares/base'
require 'social_shares/facebook'
require 'social_shares/google'
require 'social_shares/twitter'
require 'social_shares/vkontakte'
require 'social_shares/mail_ru'
require 'social_shares/odnoklassniki'
require 'social_shares/reddit'
require 'social_shares/linkedin'
require 'social_shares/pinterest'
require 'social_shares/stumbleupon'
require 'social_shares/weibo'
require 'social_shares/buffer'

module SocialShares
  class << self
    include SocialShares::StringHelper

    def config=(val)
      SocialShares::Base.config = val
    end

    SUPPORTED_NETWORKS = [
      :vkontakte,
      :facebook,
      :google,
      # :twitter,
      :mail_ru,
      :odnoklassniki,
      :reddit,
      :linkedin,
      :pinterest,
      :stumbleupon,
      :weibo,
      :buffer,
    ]

    def supported_networks
      SUPPORTED_NETWORKS
    end

    SUPPORTED_NETWORKS.each do |network_name|
      define_method(network_name) do |url|
        class_name = to_camel_case(network_name.to_s)
        SocialShares.const_get(class_name).new(url).shares
      end

      define_method("#{network_name}!") do |url|
        class_name = to_camel_case(network_name.to_s)
        SocialShares.const_get(class_name).new(url).shares!
      end
    end

    def omit(url, excluded_networks = [])
      selected_base(url, supported_networks.map(&:to_s) - excluded_networks.map(&:to_s), false)
    end

    def omit!(url, excluded_networks = [])
      selected_base(url, supported_networks.map(&:to_s) - excluded_networks.map(&:to_s), true)
    end

    def selected(url, selected_networks)
      selected_base(url, selected_networks, false)
    end

    def selected!(url, selected_networks)
      selected_base(url, selected_networks, true)
    end

    def all(url)
      selected(url, SUPPORTED_NETWORKS)
    end

    def all!(url)
      selected!(url, SUPPORTED_NETWORKS)
    end

    def total(url, selected_networks = SUPPORTED_NETWORKS)
      selected!(url, selected_networks).values.reduce(:+)
    end

    def has_any?(url, selected_networks = SUPPORTED_NETWORKS)
      lambdas = filtered_networks(selected_networks).map do |network_name|
        -> {self.send("#{network_name}!", url)}
      end
      pool = thread_pool(lambdas)
      found = false
      while !pool.empty? && !found
        sleep 0.05
        if thread = pool.find(&:stop?)
          if thread.value > 0
            pool.each(&:kill)
            found = true
          else
            pool.delete(thread)
          end
        end
      end
      found
    end

  private

    def filtered_networks(selected_networks)
      selected_networks.map(&:to_s) & SUPPORTED_NETWORKS.map(&:to_s)
    end

    def thread_pool(lambdas)
      lambdas.map { |l| Thread.new { l.call } }
    end

    def selected_base(url, selected_networks, with_exception)
      lambdas = filtered_networks(selected_networks).map do |network_name|
        method_name = with_exception ? "#{network_name}!" : network_name
        -> {{network_name => self.send(method_name, url)}}
      end
      thread_pool(lambdas).reduce({}) do |result, thread|
        thread.join
        result.merge(thread.value)
      end
    end
  end
end
