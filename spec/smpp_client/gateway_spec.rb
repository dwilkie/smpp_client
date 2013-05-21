require 'spec_helper'
require 'smpp_client/gateway'

module SmppClient
  describe Gateway do
    include ConfigHelpers

    subject { Gateway.new(load_sample_gateway_config) }

    it "should set the redis url from the config" do
      Pace.should_receive(:redis_url=).with(sample_gateway_config["redis"]["url"])
      subject
    end

    describe "#config" do
      it "should return the config that the gateway was initialized with" do
        subject.config.should == sample_gateway_config
      end
    end

    describe "#start" do
      let(:worker) { mock(Pace::Worker) }
      let(:transceiver) { mock(Smpp::Transceiver) }

      before do
        Pace::Worker.stub(:new).and_return(worker)
        worker.stub(:add_hook).and_yield
        EventMachine.stub(:connect).and_return(transceiver)
        worker.stub(:start)
      end

      it "should create a new worker for the configured queue" do
        Pace::Worker.should_receive(:new).with(sample_gateway_config["redis"]["queue"])
        subject.start
      end

      context "on start" do
        it "should connnect to the configured gateway" do
          worker.should_receive(:add_hook).with(:start)
          EventMachine.should_receive(:connect).with(
            sample_gateway_config["smpp"]["host"],
            sample_gateway_config["smpp"]["port"],
            Smpp::Transceiver,
            sample_gateway_config["smpp"].symbolize_keys,
            subject
          )
          subject.start
        end
      end

      context "when a job is received" do
        let(:job) { mock("MyJob") }
        let(:job_args) { ["1", "2442", "85512345678", "hello world", {:some => :options}] }

        before do
          job.stub(:[]).with("args").and_return(job_args)
          worker.stub(:start).and_yield(job)
          transceiver.stub(:send_mt)
        end

        it "should send an MT using the job arguments" do
          transceiver.should_receive(:send_mt).with(*job_args)
          subject.start
        end
      end
    end
  end
end
