class Facility < ApplicationRecord
  self.table_name = :peeringdb_facility
  default_scope { where(status: :ok) }

  belongs_to :organization, foreign_key: :org_id

  has_many :network_facilities
  has_many :networks, through: :network_facilities
end
