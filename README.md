Social Shares
=============
Social shares is intended to easily check social sharings of an url.

Supported networks:
* facebook
* google plus
* twitter
* vkontakte

Usage
-----
Currently all methods can raise exception when there is any error with network access.
```ruby
:000 > require 'social_shares'
 => true
:000 > SocialShares.supported_networks
 => [:vkontakte, :facebook, :google, :twitter]
:000 > url = 'https://www.ruby-toolbox.com/'
 => "https://www.ruby-toolbox.com/"
:000 > SocialShares.facebook url
  => 209
:000 > SocialShares.facebook url
 => 209
:000 > SocialShares.google url
 => 227
:000 > SocialShares.twitter url
 => 784
:000 > SocialShares.vkontakte url
 => 5
:000 > SocialShares.all url
 => {:vkontakte=>5, :facebook=>209, :google=>227, :twitter=>784}
:000 > SocialShares.selected url, %w(facebook google)
 => {:facebook=>209, :google=>227}
 # Total sum of sharings in selected networks
:000 > SocialShares.total url, %w(facebook google)
 => 436
# Note that #has_any? is faster than (#total > 0), coz it stops on first network that has at least 1 sharing
:000 > SocialShares.has_any? url, %w(facebook google)
 => true
```

Instalation
-----
Include the gem in your Gemfile:
```
gem 'social_shares'
```

Authors
----
* [Timur Kozmenko](https://twitter.com/Timrael)
