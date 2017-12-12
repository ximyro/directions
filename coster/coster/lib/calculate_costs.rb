module Coster
  class CalculateError < StandardError; end
  class CalculateCosts

    attr_reader :costs, :directions, :min_cost, :max_cost

    MACHINE_FEED = 150
    PER_MINUTE = 15
    PER_KILOMETR = 38

    def initialize(source, destination, directions_config)
      @source = source
      @destination = destination
      @directions_config = directions_config
      @costs = []
    end

    def call
      find_directions
      find_costs
      find_max_cost
      find_min_cost
    end

    private

    def find_directions
      response = directions_client.get(@source, @destination)
      raise CalculateError("Directions is not found") if !response || response["directions"].blank?
      @directions = response["directions"]
    end

    def find_costs
      @costs = @directions.map do |direction|
        find_cost(direction['duration'], direction['distance'])
      end
    end

    def find_cost(duration, distance)
      begin
        MACHINE_FEED + PER_MINUTE*duration/60.0 + PER_KILOMETR*distance/1000
      rescue
        0
      end
    end

    def find_min_cost
      @min_cost = @costs.min
    end

    def find_max_cost
      @max_cost = @costs.max
    end

    def directions_client
      @client ||= DirectionsClient.new(@directions_config)
    end
  end
end
