class Ix < ApplicationRecord
  self.table_name = :peeringdb_ix
  default_scope { where(status: :ok) }

  belongs_to :organization, foreign_key: :org_id

  has_many :ixlans
end
