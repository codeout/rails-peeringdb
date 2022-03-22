class PublicFacility < ApplicationRecord
  self.table_name = :mgmtPublicsFacilities

  belongs_to :public
  belongs_to :facility
end
