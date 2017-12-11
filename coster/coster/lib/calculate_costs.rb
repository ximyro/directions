module Coster
  class CalculateCosts

    attr_reader :costs

    def initialize(options)
      @options
    end

    def call
    end
    
    private

    def directions_host
      @options.fetch(:directions_client_host)
    end

    def directions_client
      @client ||= DirectionsClient.new(directions_host)
    end
  end
end
