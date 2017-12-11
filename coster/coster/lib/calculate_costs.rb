module Coster
  class CalculateCosts

    attr_reader :costs, :directions

    def initialize(source, destination, directions_config)
      @source = source
      @destination = destination
      @directions_config = directions_config
    end

    def call
      @directions = directions_client.get(@source, @destination)
    end

    private

    def directions_client
      @client ||= DirectionsClient.new(@directions_config)
    end
  end
end
