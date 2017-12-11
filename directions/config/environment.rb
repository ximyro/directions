require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
ActiveModelSerializers.config.adapter = :json
require_relative '../serializers/direction_serializer'
require_relative '../lib/google_directions_client'
require_relative '../directions/directions'
