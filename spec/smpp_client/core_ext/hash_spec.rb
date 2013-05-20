require 'spec_helper'

describe Hash do
  describe "#symbolize_keys!" do
    it "should destructively symbolize the keys of the hash" do
      hash = {"foo" => "bar", :bar => "foo"}
      hash.symbolize_keys!
      hash.should == {:foo => "bar", :bar => "foo" }
    end
  end
end
