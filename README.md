# Sinatra::Hijacker

A sinatra plugin to handle websockets by Rack hijacking API.

## Installation

Add this line to your application's Gemfile:

    gem 'sinatra-hijacker'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sinatra-hijacker

## Usage

Register Sinatra::Hijacker and define route by "websocket" method.

```ruby
require 'sinatra/hijacker'

class YourApp < Sinatra::Base

  register Sinatra::Hijacker

  websocket '/ws' do
    ws.onopen{ws.send_data "hello"}
  end
end
```

Note: application server must suppert Rack hijacking API, like Puma.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
