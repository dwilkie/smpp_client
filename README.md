# SmppClient

[![Build Status](https://travis-ci.org/dwilkie/smpp_client.png)](https://travis-ci.org/dwilkie/smpp_client)

[SmppClient](https://github.com/dwilkie/smpp_client) is a high level SMPP Client written in Ruby. You can use it to connect to SMSCs, send out MT (Mobile Terminated) messages and queue MO (Mobile Originated) messages for processing. [SmppClient](https://github.com/dwilkie/smpp_client) uses [Pace](https://github.com/groupme/pace) to process [Resque](https://github.com/resque/resque) jobs for sending out MTs. Behind the scenes it uses an updated version of [ruby-smpp](https://github.com/dwilkie/ruby-smpp) for the low level processing.

## Installation

Add the following lines to your application's Gemfile:

    gem "smpp_client", :git => "git://github.com/dwilkie/smpp_client.git"
    gem "ruby-smpp",   :git => "git://github.com/dwilkie/ruby-smpp.git"
    gem "pace",        :git => "git://github.com/groupme/pace.git"

And then execute:

    bundle

## Configuration

Generate a sample configuration file for your SMPP connection

    bundle exec smpp_client configure GATEWAY_NAME

Replace `GATEWAY_NAME` with the name of your gateway.

Edit the generated `gateways.yml` file and replace the configuration with the real configuration of the SMSC.

## Usage

Start the Smpp Client

    bundle exec smpp_client start GATEWAY_NAME

Replace `GATEWAY_NAME` with the name of your gateway.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
