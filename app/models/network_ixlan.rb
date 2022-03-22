class NetworkIxlan < ApplicationRecord
  self.table_name = :peeringdb_network_ixlan
  default_scope { where(status: :ok) }

  belongs_to :network
  belongs_to :ixlan
end
