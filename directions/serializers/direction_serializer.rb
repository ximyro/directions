class DirectionSerializer < ActiveModel::Serializer
  attributes :distance, :duration

  def read_attribute_for_serialization(attr)
    object[attr]
  end
end
