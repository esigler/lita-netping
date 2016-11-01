# lita-netping

[![Build Status](https://img.shields.io/travis/esigler/lita-netping/master.svg)](https://travis-ci.org/esigler/lita-netping)
[![MIT License](https://img.shields.io/badge/license-MIT-brightgreen.svg)](https://tldrlegal.com/license/mit-license)
[![RubyGems :: RMuh Gem Version](http://img.shields.io/gem/v/lita-netping.svg)](https://rubygems.org/gems/lita-netping)
[![Coveralls Coverage](https://img.shields.io/coveralls/esigler/lita-netping/master.svg)](https://coveralls.io/r/esigler/lita-netping)
[![Code Climate](https://img.shields.io/codeclimate/github/esigler/lita-netping.svg)](https://codeclimate.com/github/esigler/lita-netping)
[![Gemnasium](https://img.shields.io/gemnasium/esigler/lita-netping.svg)](https://gemnasium.com/esigler/lita-netping)

An IP ping plugin for [Lita](https://github.com/jimmycuadra/lita).

## Installation

Add lita-netping to your Lita instance's Gemfile:

``` ruby
gem "lita-netping"
```

## Configuration

none

## Usage

Examples:

```
ping google.com - Ping google.com via normal ICMP
ping icmp google.com - Ping google.com via normal ICMP (same as above)
ping http://www.google.com - Ping google.com via HTTP
ping tcp://ldap.server:389 - Ping a TCP service running on ldap.server on port 389
ping tcp app.server:8080 - Ping a TCP service running on app.server on port 8080
```

Supported protocols are:

* `http` - Ping a web service. It is usually simplest to just specify the URI like you would in a web browser.
* `icmp` - The default if none is specified. This is your standard ping.
* `tcp` - Verify that a TCP service is listening and responding. Note that this doesn't guarantee that the service is not misbehaving, just that it responds on the proper port.

Syntax:

```
ping [protocol] <target> - Ping <target> (either DNS name, IP address, or URI)
```

## Note

This plugin uses the net-ping library, and the ICMP ping uses the "Net::Ping::External" check,
so it will use the "ping" equivalent on whatever host it's running on.

## License

[MIT](http://opensource.org/licenses/MIT)
