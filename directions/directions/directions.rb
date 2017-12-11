module Directions
  class API < Grape::API
    version 'v1', using: :header, vendor: 'frontend'
    format :json
    prefix :api
    formatter :json, Grape::Formatter::ActiveModelSerializers

    helpers do
      def google_directions_client
        @client ||= GoogleDirectionsClient.new
      end
    end

    resource :directions do
      desc 'Calculate path'
      params do
        requires :source, type: Hash do
          requires :lat, type: Float
          requires :long, type: Float
        end
        requires :destination, type: Hash do
          requires :lat, type: Float
          requires :long, type: Float
        end
      end
      post :find, root: 'directions', each_serializer: DirectionSerializer do
        google_directions_client.calculate(source: params["source"], destination: params["destination"])
      end
    end
    formatter :json, Grape::Formatter::ActiveModelSerializers
  end
end
