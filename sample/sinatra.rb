require 'sinatra/base'
require 'rack/handler/puma'
require 'sinatra/hijacker'

class App < Sinatra::Base
  register Sinatra::Hijacker

  get '/' do
    index_html
  end
  
  websocket '/ws' do
    ws.onmessage do |msg|
      ws.send_data "Hello, #{msg}!"
    end
  end
  
  helpers do
    def index_html
      <<-EOS
      <html>
      <body>
      <script>
      var ws = new WebSocket('ws://#{env["HTTP_HOST"]}/ws');
      ws.onmessage = function(msg){
        var e = document.createElement("h1");
        e.textContent = msg.data;
        document.body.appendChild(e);
      };
      ws.onopen = function(){ws.send("World")};
      </script>
      </body>
      <html>
      EOS
    end
  end
end

Rack::Handler::Puma.run App if __FILE__ == $0
