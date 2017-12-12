module Coster
  class DirectionsClient

    PATH = "/api/directions/find"

    def initialize(options)
      @options = options
    end

    def get(source, destination)
      begin
        connection.post(PATH, json:
        {
          source: source,
          destination: destination
        }
        ).parse
      rescue Exception => e
        logger.error e.message
        logger.error e.backtrace.join("\n")
        return
      end
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
