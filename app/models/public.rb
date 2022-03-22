class Public < ApplicationRecord
  self.table_name = :mgmtPublics

  has_many :public_facilities
  has_many :facilities, through: :public_facilities

  has_many :participant_publics
  has_many :participants, through: :participant_publics
end
