class GoogleDirectionsClient
  HOST = "http://maps.googleapis.com/maps/api/directions"
  DEFAULT_FORMAT = "json"

  def initialize
  end

  def calculate(source:, destination:, format: nil)
    format ||= DEFAULT_FORMAT
    begin
      response = connection.post(build_path(format), params: {
        origin: format_coord(source),
        destination: format_coord(destination)
      }.merge!(default_params))
      routes = response.parse.dig("routes")
      routes.inject([]) do |result, route|
        next if route["legs"].blank?
        result |= route["legs"].map do |leg|
          {
            distance: leg.dig("distance", "value"),#meters

            duration: leg.dig("duration", "value")#seconds
          }
        end
      end
    rescue Exception => e
      logger.error e.message
      logger.error e.backtrace.join("\n")
      return
    end
  end

  private

  def logger
    Logger.new(STDOUT)
  end

  def build_path(format)
    [HOST, format].join("/")
  end

  def format_coord(data)
    data.values_at(:lat, :long).join(",")
  end

  def default_params
    {
      alternatives: true,
      mode: 'driving',
      units: "metric"
    }
  end

  def connection
     @connection = HTTP.persistent(HOST)
  end
end
