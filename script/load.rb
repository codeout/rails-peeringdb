require 'json'

data = JSON.load($<.read)

Organization.import(data['org']['data'].map { |d|
  Organization.new(d)
})

Ix.import(data['ix']['data'].map { |d|
  Ix.new(d)
})

Facility.import(data['fac']['data'].map { |d|
  d.delete 'org_name'
  Facility.new(d)
})

Ixlan.import(data['ixlan']['data'].map { |d|
  Ixlan.new(d)
})

Network.import(data['net']['data'].map { |d|
  Network.new(d)
})

NetworkFacility.import(data['netfac']['data'].map { |d|
  %w[city country name].each { |i| d.delete i }
  d['facility_id'] = d.delete('fac_id')
  d['network_id'] = d.delete('net_id')
  NetworkFacility.new(d)
})

NetworkIxlan.import(data['netixlan']['data'].map { |d|
  %w[name ix_id].each { |i| d.delete i }
  d['network_id'] = d.delete('net_id')
  NetworkIxlan.new(d)
})
