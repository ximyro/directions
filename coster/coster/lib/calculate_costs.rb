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
      cached = find_cached_costs
      if cached.empty?
        response = directions_client.get(@source, @destination)
        raise ::Coster::CalculateError, "Directions is not found"  if !response || response["directions"].blank?
        @directions = response["directions"]
      else
        @directions = cached.map do |cost|
          {
            'duration' => cost.duration,
            'distance' => cost.distance
          }
        end
      end
    end

    def find_costs
      @costs = @directions.map do |direction|
        price = find_cost(direction['duration'], direction['distance'])
        update_directions_cache(direction, price)
        price
      end
    end

    def find_cached_costs
      sources = Cost.where(
        source: {
          "$near": {
            "$geometry": {
              type: "Point",
              coordinates: @source.values
            },
          '$maxDistance' => 200,
          '$minDistance' => 0
          }
        })
      destinations = Cost.where(
        destination:{
          "$near": {
            "$geometry": {
              type: "Point",
              coordinates: @destination.values
            },
          '$maxDistance' => 200,
          '$minDistance' => 0
          }
      })
      Cost.find(destinations.map(&:id) & sources.map(&:id))
    end

    def find_cost(duration, distance)
      begin
        machine_feed + per_minute*duration/60.0 + per_kilometr*distance/1000
      rescue
        ::Coster::API.logger.error("Error find cost for distance: #{distance}, duration: #{duration}")
      end
    end

    def update_directions_cache(direction, price)
      cost = Cost.find_or_initialize_by(source: @source.values, destination: @destination.values)
      cost.assign_attributes(duration: direction['duration'], distance: direction['distance'], price: price)
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
