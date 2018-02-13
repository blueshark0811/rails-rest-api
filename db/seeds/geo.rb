config = ActiveRecord::Base.configurations[Rails.env]

base_params = []
base_params << "-U #{config['username']}" if config['username']
base_params << "-h #{config['host']}" if config['host']
base_params << "-W #{config['password']}" if config['password']
base_params = base_params.join(' ')

if Country.count == 0
  cmd = "psql #{base_params} -d #{config['database']} < db/seeds/geo/countries.sql"
  p cmd
  system(cmd)
end

if State.count == 0  
  cmd = "psql #{base_params} -d #{config['database']} < db/seeds/geo/states.sql"
  p cmd
  system(cmd)
end

if City.count == 0 
  cmd = "psql #{base_params} -d #{config['database']} < db/seeds/geo/cities.sql"
  p cmd 
  system(cmd)
end



us_states = [["Alabama", "AL"],
["Alaska", "AK"],
["Arizona", "AZ"],
["Arkansas", "AR"],
["California", "CA"],
["Colorado", "CO"],
["Connecticut", "CT"],
["Delaware", "DE"],
["Florida", "FL"],
["Georgia", "GA"],
["Hawaii", "HI"],
["Idaho", "ID"],
["Illinois", "IL"],
["Indiana", "IN"],
["Iowa", "IA"],
["Kansas", "KS"],
["Kentucky", "KY"],
["Louisiana", "LA"],
["Maine", "ME"],
["Maryland", "MD"],
["Massachusetts", "MA"],
["Michigan", "MI"],
["Minnesota", "MN"],
["Mississippi", "MS"],
["Missouri", "MO"],
["Montana", "MT"],
["Nebraska", "NE"],
["Nevada", "NV"],
["New Hampshire", "NH"],
["New Jersey", "NJ"],
["New Mexico", "NM"],
["New York", "NY"],
["North Carolina", "NC"],
["North Dakota", "ND"],
["Ohio", "OH"],
["Oklahoma", "OK"],
["Oregon", "OR"],
["Pennsylvania", "PA"],
["Rhode Island", "RI"],
["South Carolina", "SC"],
["South Dakota", "SD"],
["Tennessee", "TN"],
["Texas", "TX"],
["Utah", "UT"],
["Vermont", "VT"],
["Virginia", "VA"],
["Washington", "WA"],
["West Virginia", "WV"],
["Wisconsin", "WI"],
["Wyoming", "WY"],
["Washington DC", "DC"]]


us_states.each do |us_state|
  if state = State.where(name: us_state.first).last
    state.update_attribute :code, us_state.last
  else
    p 'worning, can not find state:', us_state, '*'*100
  end
end
