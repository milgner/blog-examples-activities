require 'types/distance'

class Activity < ApplicationRecord
  belongs_to :user
  attribute :distance, :distance_in_meters
end
