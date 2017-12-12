module Coster
  class CalculateCosts

    attr_reader :costs, :directions, :min_cost, :max_cost

    def initialize(source, destination)
      @source = source
      @destination = destination
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
      raise ::Coster::CalculateError, "Directions is not found"  if !response || response["directions"].blank?
      @directions = response["directions"]
    end

    def find_costs
      @costs = @directions.map do |direction|
        find_cost(direction['duration'], direction['distance'])
      end
    end

    def find_cost(duration, distance)
      begin
        machine_feed + per_minute*duration/60.0 + per_kilometr*distance/1000
      rescue
        ::Coster::API.logger.error("Error find cost for distance: #{distance}, duration: #{duration}")
      end
    end

    def machine_feed
      Settings.dig("tarif", "machine_feed")
    end

    def per_minute
      Settings.dig("tarif", "per_minute")
    end

    def per_kilometr
      Settings.dig("tarif", "per_kilometr")
    end

    def find_min_cost
      @min_cost = @costs.min
    end

    def find_max_cost
      @max_cost = @costs.max
    end

    def directions_client
      @client ||= DirectionsClient.new(Settings[:directions])
    end
  end
end
