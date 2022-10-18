class Mission < ApplicationRecord
  belongs_to :scientist
  belongs_to :planet

  validates :name, presence: true
  validates :scientist, presence: true
  validates :planet, presence: true

  # a scientist cannot join the same mission twice
  # same planet only once?
  validate :no_same_mission_twice

  def no_same_mission_twice
    return nil if scientist.nil? 
    errors.add(:scientist, 'already did this mission') if scientist.missions.map(&:name).include?(name)
  end
end
