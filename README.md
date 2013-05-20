# SmppClient

SmppClient is a high level Smpp Client written in Ruby. You can use it to connect to SMSCs, send out MT (Mobile Terminated) messages and queue MO (Mobile Originated) messages for processing. SmppClient uses Resque to queue MOs for processing and send out MTs.

## Installation

Add this line to your application's Gemfile:

    gem 'smpp_client'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install smpp_client

## Configuration

Generate a sample configuration file for your SMPP connection

    bundle exec smpp_client configure GATEWAY_NAME

Replace GATEWAY_NAME with the name of your gateway.

Edit the generated `gateways.yml` file and replace the configuration with the real configuration of the SMSC.

## Usage

Start the Smpp Client

    bundle exec smpp_client start GATEWAY_NAME

Replace GATEWAY_NAME with the name of your gateway.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
