# encoding: utf-8

require 'thor'
require 'yaml'
require 'smpp_client/generators/gateway_config/gateway_config_generator'
require 'smpp_client/gateway'

module SmppClient
  module Cli
    class SmppClientCommand < Thor
      map %w(-v --version) => :version
      map %w(-) => :start

      check_unknown_options!

      desc "start GATEWAY", "starts the gateway with the given name"
      method_option :config_file, :default => "#{Dir.pwd}/gateways.yml", :desc => "gateway configuration file"
      def start(gateway)
        raise ArgumentError.new("Gateway configuration file #{options[:config_file]} does not exist") unless File.exists?(options[:config_file])
        gateway_config = YAML.load_file(options[:config_file])["gateways"][gateway]
        raise ArgumentError.new("No configuration for the gateway '#{gateway}' found in #{options[:config_file]}") unless gateway_config
        SmppClient::Gateway.new(gateway_config).start
      end

      desc "configure GATEWAY", "generates a configuration file for the given gateway"
      def configure(gateway)
        SmppClient::Generators::GatewayConfigGenerator.start([gateway])
      end

      desc "version", "Shows the SmppClient version"
      def version
        say "SmppClient v#{SmppClient::VERSION}"
      end
    end
  end
end
