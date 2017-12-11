module Coster
  class DirectionsClient

    PATH = "/api/directions/find"

    def initialize(options)
      @options = options
    end

    def get(source, destination)
      connection.post(PATH, json:
        {
         source: source,
         destination: destination
        }
      )
    end

    private

    def host
      @options.fetch(:host)
    end

    def connection
      @connection = HTTP.persistent(host)
    end
  end
end
