class Ixlan < ApplicationRecord
  self.table_name = :peeringdb_ixlan
  default_scope { where(status: :ok) }

  belongs_to :ix

  has_many :network_ixlans
  has_many :networks, through: :network_ixlans
end
