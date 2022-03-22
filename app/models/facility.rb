class Facility < ApplicationRecord
  self.table_name = :mgmtFacilities
  self.inheritance_column = :_type

  has_many :public_facilities
  has_many :publics, through: :public_facilities

  has_many :participant_privates
  has_many :participants, through: :participant_privates
end
