class DirectionsClient

  HOST = "localhost:9292"
  PATH = "/api/destintations/find" 

  def initialize
  end

  def get(source:, destination:)
    connection.post("/api/destinations/find", params:
      {
       source: source,
       destination: destination
      }
    ) 
  end

  private

  def connection
    @connection = HTTP.persistent(HOST)
  end
end
