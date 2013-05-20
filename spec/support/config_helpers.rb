require 'yaml'

module ConfigHelpers
  def sample_config
    @sample_config ||= File.read(File.expand_path(File.join(File.dirname(__FILE__), '../fixtures/gateways.yml')))
  end

  def sample_gateway_config
    @sample_gateway_config ||= YAML.load(sample_config)["gateways"]["smart"]
  end

  alias_method :load_sample_gateway_config, :sample_gateway_config
end
