require 'grape'

module Coster
  class API < Grape::API
    version 'v1', using: :header, vendor: 'coster'
    format :json
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
      end
    end
  end
end
