require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
Settings = {
  directions: {
    host: 'http://localhost:9293'
  }
}
require_relative '../serializers/cost_serializer'
require_relative '../coster/coster'
