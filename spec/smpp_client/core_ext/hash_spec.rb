require 'spec_helper'
require 'smpp_client/core_ext/hash'

describe Hash do
  describe "#symbolize_keys" do
    it "should return a new hash with the keys symbolized" do
      hash = {"foo" => "bar", :bar => "foo"}
      hash.symbolize_keys.should == {:foo => "bar", :bar => "foo" }
    end
  end
end
