class ParticipantPublic < ApplicationRecord
  self.table_name = :peerParticipantsPublics

  belongs_to :participant
  belongs_to :public
end
