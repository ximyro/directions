require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
ActiveModelSerializers.config.adapter = :json
require_relative '../serializers/direction_serializer.rb'
require_relative '../lib/google_directions_client.rb'
require_relative '../directions/directions.rb'
