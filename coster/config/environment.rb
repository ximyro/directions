require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
ActiveModelSerializers.config.adapter = :json
Settings = {
  directions: {
    host: 'http://localhost:9293'
  }
}
require_relative '../coster/coster'
