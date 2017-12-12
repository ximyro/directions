class Cost
  include Mongoid::Document
  include Mongoid::Timestamps
  field :source, type: Array
  field :destination, type: Array
  field :duration, type: Integer
  field :distance, type: Integer
  field :price, type: Float

  index({ source: "2dsphere" }, { min: -200, max: 200 })
  index({ destination: "2dsphere" }, { min: -200, max: 200 })
end
