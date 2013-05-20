module SmppClient
  class Gateway
    require "smpp"
    require "pace"
    require "resque"

    def initialize(config)
      @config = config
    end

    def start
      worker.add_hook(:start) do
        connect!
      end

      worker.start do |job|
        connection.send_mt(uuid.generate, *job["args"])
      end
    end

    def mo_received(transceiver, pdu)
      logger.info "Delegate: mo_received: from #{pdu.source_addr} to #{pdu.destination_addr}: #{pdu.short_message}"
    end

    def delivery_report_received(transceiver, pdu)
      logger.info "Delegate: delivery_report_received: ref #{pdu.msg_reference} stat #{pdu.stat}"
    end

    def message_accepted(transceiver, mt_message_id, pdu)
      logger.info "Delegate: message_accepted: id #{mt_message_id} smsc ref id: #{pdu.message_id}"
    end

    def message_rejected(transceiver, mt_message_id, pdu)
      logger.info "Delegate: message_rejected: id #{mt_message_id} smsc ref id: #{pdu.message_id}"
    end

    def bound(transceiver)
      logger.info "Delegate: transceiver bound"
    end

    def unbound(transceiver)
      logger.info "Delegate: transceiver unbound"
      EventMachine.stop_event_loop
    end

    private

    def connection
      @connection ||= EventMachine.connect(
        @config[:host],
        @config[:port],
        Smpp::Transceiver,
        @config,
        self    # delegate that will receive callbacks on MOs and DRs and other events
      )
    end
    alias_method :connect!, :connection

    def uuid
      @uuid ||= UUID.new
    end

    def worker
      @worker ||= Pace::Worker.new(ENV["PACE_QUEUE"] || "normal")
    end

    def logger
      Pace.logger
    end
  end
end
