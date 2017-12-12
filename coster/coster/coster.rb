require_relative './lib/calculate_error'
require_relative './lib/calculate_costs'
require_relative './lib/directions_client'
module Coster
  class API < Grape::API
    version 'v1', using: :header, vendor: 'coster'
    format :json
    rescue_from CalculateError do |e|
      error!({ message: e}, 400)
    end
    prefix :api
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
        use_case = CalculateCosts.new(params[:source], params[:destination])
        use_case.call
        {
          costs: use_case.costs,
          min: use_case.min_cost,
          max: use_case.max_cost
        }
      end
    end
  end
end
