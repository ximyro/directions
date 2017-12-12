require 'rubygems'
require 'bundler/setup'
require 'yaml'
Bundler.require(:default)
require_relative './settings'
require_relative '../coster/models/cost'
require_relative './mongoid'
require_relative '../coster/coster'
