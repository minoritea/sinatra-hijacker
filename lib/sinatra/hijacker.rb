require "sinatra/hijacker/version"
require "rack/hijack_wrapper"
require "tubesock"

module Sinatra
  module Hijacker
    class Middleware
      def initialize app
        @app = app
      end

      # Taken from https://github.com/simulacre/sinatra-websocket/
      # Originally taken from skinny https://github.com/sj26/skinny and updated to support Firefox
      def websocket? env
        env['HTTP_CONNECTION'] && env['HTTP_UPGRADE'] &&
          env['HTTP_CONNECTION'].split(',').map(&:strip).map(&:downcase).include?('upgrade') &&
          env['HTTP_UPGRADE'].downcase == 'websocket'
      end

      def call env
        if websocket? env
          env['REQUEST_METHOD'] = 'WEBSOCKET'
        end
        @app.call env
      end
    end

    def self.registered app
      app.use Middleware
      app.helpers do
        def ws
          env['sinatra.hijacker.websocket'] ||= Tubesock.hijack(env).tap &:listen
        end
      end
    end
    
    def websocket(path, opts = {}, &bk)
      route 'WEBSOCKET',     path, opts, &bk
    end
  end
end
