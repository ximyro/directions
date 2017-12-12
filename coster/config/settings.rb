config_file = [File.dirname(__FILE__), "..", "config.yml"].join("/")
unless File.exists?(config_file)
  fail "Config file is not exists"
end
Settings = YAML.load_file(config_file)
