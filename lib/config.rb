class Config
  @@cache = {}

  def self.get(config_name, with_env = true)
    @@cache[config_name] ||= uncached(config_name, with_env)
  end

  def self.uncached(config_name, with_env = true)
    hash = YAML.load_file("#{Rails.root}/config/#{config_name}.yml")

    res = hash['default'] || {}

    hash = hash[Rails.env] if with_env

    (hash ? res.deep_merge(hash) : res).with_indifferent_access
  end
end