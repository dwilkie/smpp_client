require 'spec_helper'
require 'smpp_client/gateway'

module SmppClient
  describe Gateway do
    include ConfigHelpers

    subject { Gateway.new(load_sample_gateway_config) }

    describe "#config" do
      it "should return the config that the gateway was initialized with" do
        subject.config.should == sample_gateway_config
      end
    end

    describe "#start" do
      it "should do something" do
        pending
      end
    end
  end
end
