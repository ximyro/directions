require 'grape'

module Coster
  class API < Grape::API
    version 'v1', using: :header, vendor: 'frontend'
    format :json
    prefix :api

    desc 'Return cost of path'
    params do
      requires :lat, :long
    end
    post :calculate do
     puts "asd" 
    end
  end
end
