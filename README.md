Social Shares
=============
Social shares is intended to easily check social sharings of an url.

Supported networks:
* [facebook](http://www.facebook.com/)
* [google plus](https://plus.google.com)
* [twitter](https://twitter.com/)
* [reddit](http://www.reddit.com/)
* [linkedin](https://www.linkedin.com/)
* [pinterest](http://www.pinterest.com/)
* [stumbleupon](http://www.stumbleupon.com/)
* [vkontakte](http://vkontakte.ru/)
* [mail.ru](http://mail.ru/)
* [odnoklassniki](http://www.odnoklassniki.ru/)

Usage
-----
```ruby
:000 > require 'social_shares'
 => true
:000 > SocialShares.supported_networks
 => [:vkontakte, :facebook, :google, :twitter, :mail_ru, :odnoklassniki, :reddit, :linkedin, :pinterest, :stumbleupon]
:000 > url = 'http://www.apple.com/'
 => "http://www.apple.com/"
:000 > SocialShares.facebook url
 => 394927
:000 > SocialShares.google url
 => 28289
:000 > SocialShares.twitter url
 => 1164675
# in case of exception it will return nil value
:000 > SocialShares.twitter url
 => nil
# but this method will raise it
:000 > SocialShares.twitter! url
  => RestClient::RequestTimeout: Request Timeout
:000 > SocialShares.all url
 => {:vkontakte=>44, :facebook=>399027, :google=>28346, :twitter=>1836, :mail_ru=>37, :odnoklassniki=>1, :reddit=>2361, :linkedin=>nil, :pinterest=>21011, :stumbleupon=>43035}
# same for #all! method, it will not handle exceptions
:000 > SocialShares.all! url
 => RestClient::RequestTimeout: Request Timeout
:000 > SocialShares.selected url, %w(facebook google linkedin)
 => {:facebook=>394927, :google=>28289, :linkedin=>nil}
:000 > SocialShares.selected! url, %w(facebook google linkedin)
 => RestClient::RequestTimeout: Request Timeout
# Total sum of sharings in selected networks
:000 > SocialShares.total url, %w(facebook google)
 => 423216
# Second arg is optional, by default it takes all networks
:000 > SocialShares.total url
 => 1631102
# Note that #has_any? is faster than (#total > 0), coz it stops on first network that has at least 1 sharing
:000 > SocialShares.has_any? url, %w(facebook google)
 => true
# Second arg is optional, by default it takes all networks
:000 > SocialShares.has_any? url
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
