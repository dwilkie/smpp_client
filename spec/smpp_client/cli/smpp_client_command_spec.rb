require 'spec_helper'
require 'smpp_client/cli/smpp_client_command'

module SmppClient
  module Cli
    describe SmppClientCommand do
      include ConfigHelpers

      let(:default_config_path) { File.join(Dir.pwd, "gateways.yml") }

      subject { SmppClientCommand }

      def run_command(command, *args)
        subject.start(args.unshift(command))
      end

      describe "#version" do
        subject { SmppClientCommand.new }

        def run_command
          subject.version
        end

        before do
          subject.stub(:say)
        end

        it "should output the version name" do
          subject.should_receive(:say).with("SmppClient v#{SmppClient::VERSION}")
          run_command
        end
      end

      describe "#configure" do
        def run_command(gateway_name)
          super("configure", gateway_name)
        end

        before do
          SmppClient::Generators::GatewayConfigGenerator.stub(:start)
        end

        it "should invoke the generator with the options" do
          SmppClient::Generators::GatewayConfigGenerator.should_receive(:start).with(["foo"])
          run_command("foo")
        end
      end

      describe "#start" do
        def run_command(options = {})
          args = ["-", options[:gateway] || "smart"]
          args << "--config-file=#{options[:config_file]}" if options[:config_file]
          super(*args)
        end

        context "given a valid config file exists in the default location" do
          def generate_config(config, output_path)
            FileUtils.mkdir_p(File.dirname(output_path))
            File.open(output_path, 'w') { |file| file.write(config) }
          end

          def run_command(options = {})
            default_config_path
            sample_config
            FakeFS do
              generate_config(sample_config, default_config_path)
              super
            end
          end

          context "without passing --config-file" do
            context "when I pass the name of a gateway which is specified in the config file" do
              let(:gateway) { mock(SmppClient::Gateway) }

              before do
                SmppClient::Gateway.stub(:new).and_return(gateway)
                gateway.stub(:start)
              end

              it "should start the gateway with the specified config" do
                SmppClient::Gateway.should_receive(:new).with(sample_gateway_config)
                gateway.should_receive(:start)
                run_command
              end
            end

            context "when I pass the name of a gateway which is not specified in the config file" do
              it "should raise an error" do
                expect { run_command(:gateway => "beeline")}.to raise_error(
                  ArgumentError,
                  "No configuration for the gateway 'beeline' found in #{default_config_path}"
                )
              end
            end
          end

          context "passing --config-file=/path/to/some/non/existant/file" do
            it "should raise an error" do
              expect { run_command(:config_file => "/path/to/some/non/existant/file") }.to raise_error(
                ArgumentError,
                "Gateway configuration file /path/to/some/non/existant/file does not exist"
              )
            end
          end
        end
      end
    end
  end
end
