require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require_relative '../serializers/cost_serializer'
require_relative '../coster/lib/calculate_costs'
require_relative '../coster/coster'
