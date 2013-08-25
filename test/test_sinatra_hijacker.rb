require 'minitest/autorun'
require 'rack/test'
require 'sinatra/base'
require 'sinatra/hijacker'
require 'socket'

class HijackerTest < MiniTest::Test
  include Rack::Test::Methods

  class App < Sinatra::Base
    register Sinatra::Hijacker
    get '/' do
      200
    end
    websocket '/ws' do
      ws.onmessage do
        throw :onmessage
      end
    end
  end
  
  def app
    App
  end
  
  def test_get
    get '/'
    assert last_response.ok?
  end
  
  def test_through_websocket?
    assert_raises Tubesock::HijackNotAvailable do
      get '/ws', {}, {'HTTP_CONNECTION' => 'UPGRADE', 'HTTP_UPGRADE' => 'WEBSOCKET' }
    end
  end
end