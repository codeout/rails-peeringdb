class NetworkFacility < ApplicationRecord
  self.table_name = :peeringdb_network_facility
  default_scope { where(status: :ok) }

  belongs_to :network
  belongs_to :facility
end
