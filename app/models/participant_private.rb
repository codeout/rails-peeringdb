class ParticipantPrivate < ApplicationRecord
  self.table_name = :peerParticipantsPrivates

  belongs_to :participant
  belongs_to :facility
end
