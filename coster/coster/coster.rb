module Coster
  class API < Grape::API
    version 'v1', using: :header, vendor: 'coster'
    format :json
    prefix :api
    formatter :json, Grape::Formatter::ActiveModelSerializers

    resource :cost do
      desc 'Return cost of path'
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
      post :calculate do
        use_case = CalculateCosts.new("http://localhost:9293")
        use_case.call
        use_case.costs
      end
    end
    formatter :json, Grape::Formatter::ActiveModelSerializers
  end
end
