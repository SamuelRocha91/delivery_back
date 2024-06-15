class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  geocoded_by :full_street_address

  after_validation :geocode

  def full_street_address
    "#{street}, #{number}, #{city}, #{state}, #{postal_code}"
  end

  def distance_to(other_address)
    return nil unless self.latitude && self.longitude && other_address.latitude && other_address.longitude

    Geocoder::Calculations.distance_between(
      [self.latitude, self.longitude],
      [other_address.latitude, other_address.longitude]
    )
  end

end

