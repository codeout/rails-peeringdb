class Network < ApplicationRecord
  self.table_name = :peeringdb_network
  default_scope { where(status: :ok) }

  belongs_to :organization, foreign_key: :org_id

  has_many :network_facilities
  has_many :facilities, through: :network_facilities

  has_many :network_ixlans
  has_many :ixlans, through: :network_ixlans
end
