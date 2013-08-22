require "sinatra/hijacker/version"

module Sinatra
  module Hijacker
    def call env
      p self
      if websocket? env
        env['sinatra.hijacker.websocket'] = Tubesock.hijack(env).tap &:listen
        env['REQUEST_METHOD'] = 'WEBSOCKET'
        super
        [101, {}, []]
      else
        super
      end
    end

    # Taken from https://github.com/simulacre/sinatra-websocket/
    # Originally taken from skinny https://github.com/sj26/skinny and updated to support Firefox
    def websocket? env
      env['HTTP_CONNECTION'] && env['HTTP_UPGRADE'] &&
        env['HTTP_CONNECTION'].split(',').map(&:strip).map(&:downcase).include?('upgrade') &&
        env['HTTP_UPGRADE'].downcase == 'websocket'
    end
    
    def self.registered app
      app.helpers do
        def ws
          env['sinatra.hijacker.websocket']
        end
      end
    end
    
    def websocket(path, opts = {}, &bk)
      route 'WEBSOCKET',     path, opts, &bk
    end

  end
end
