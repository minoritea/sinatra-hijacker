require 'rack'

#A monkey patch for HijackWrapper in rack/lint
class Rack::Lint::HijackWrapper
  def_delegators :@io, :to_io, :recvfrom
end