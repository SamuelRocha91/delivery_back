class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  geocoded_by :address

  after_validation :geocode

  def address
    country = 'Brazil'
    [street, city, state, country].compact.join(', ')
  end

  def distance_to(other_address)
    return nil unless self.latitude && self.longitude && other_address.latitude && other_address.longitude

    Geocoder::Calculations.distance_between(
      [self.latitude, self.longitude],
      [other_address.latitude, other_address.longitude]
    )
  end

end

