# encoding: utf-8

module SmppClient
  module Generators
    class GatewayConfigGenerator < Thor::Group
      include Thor::Actions

      argument :name

      def self.source_root
        File.dirname(__FILE__)
      end

      def create_gateway_config
        template "templates/gateways.yml.erb", "gateways.yml"
      end
    end
  end
end
