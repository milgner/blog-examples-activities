class Distance
  attr_reader :meters

  class << self
    def from_meters(meters)
      new.tap { |d| d.instance_eval { @meters = meters } }
    end
  end

  def ==(other)
    ensure_distance(other)
    other.meters == meters
  end

  def +(other)
    ensure_distance(other)

    Distance.from_meters(meters + other.meters)
  end

  def -(other)
    ensure_distance(other)

    Distance.from_meters(meters - other.meters)
  end

  def miles
    meters * 6.213712e-4
  end

  def yards
    meters * 1.093613
  end

  def parsecs
    meters * 3.240779e-17
  end

  private

  def ensure_distance(other)
    return if other.is_a?(Distance)
    raise ArgumentError, "#{other} (#{other.class}) is not a Distance"
  end
end

class Numeric
  def meters
    Distance.from_meters(self)
  end
end

class DistanceInMetersType < ActiveRecord::Type::Value
  def cast(value)
    return value if value.is_a?(Distance)

    raise ArgumentError, "Can't cast from #{value.class}" unless value.is_a?(Numeric) || value.respond_to?(:to_f)

    Distance.from_meters(value.to_f)
  end

  def serialize(value)
    raise ArgumentError unless value.is_a?(Distance)

    value.meters
  end
end

ActiveRecord::Type.register(:distance_in_meters, DistanceInMetersType)
