require "rack/ebpf/version"
require "usdt_marker"

module Rack
  class EBPF
    REQUEST_START  = 0
    REQUEST_FINISH = 1

    def initialize(app, marker_nr = 1)
      @app = app
      @marker_nr = marker_nr
    end

    def call(env)
      UsdtMarker.probe_i2(@marker_nr, REQUEST_START)
      @app.call(env)
      UsdtMarker.probe_i2(@marker_nr, REQUEST_FINISH)
    end
  end
end
