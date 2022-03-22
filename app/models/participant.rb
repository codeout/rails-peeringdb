class Participant < ApplicationRecord
  self.table_name = :peerParticipants

  has_many :participant_privates
  has_many :facilities, through: :participant_privates

  has_many :participant_publics
  has_many :publics, through: :participant_publics
end
