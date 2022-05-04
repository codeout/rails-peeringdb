require 'json'

ixs = Hash[Public.includes(:participants).where(country: 'JP').group_by(&:city).map { |c, publics|
  [c, publics.map(&:participants).flatten.uniq]
}]

privates = Hash[Facility.includes(:participants).where(country: 'JP').group_by(&:city).map { |c, facilities|
  [c, facilities.map(&:participants).flatten.uniq]
}]

cities = (ixs.keys + privates.keys).uniq
stats = Hash[cities.map { |c|
  [c, {
    ix: ixs[c]&.count || 0,
    private: privates[c]&.count || 0,
    total: ((ixs[c] || []) + (privates[c] || [])).uniq.count
  }]
}]

def upcase_keys(hash)
  normalized = {}

  hash.each do |k1, v|
    if normalized.has_key?(k1.upcase)
      v.keys.each do |k2|
        normalized[k1.upcase][k2] += v[k2]
      end
    else
      normalized[k1.upcase] = v.dup
    end
  end

  normalized
end

print JSON.dump(upcase_keys(stats))
