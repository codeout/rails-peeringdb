class Organization < ApplicationRecord
  self.table_name = :peeringdb_organization
  default_scope { where(status: :ok) }

  has_many :facilities, foreign_key: :org_id
  has_many :ixs, foreign_key: :org_id
  has_many :networks, foreign_key: :org_id
end
