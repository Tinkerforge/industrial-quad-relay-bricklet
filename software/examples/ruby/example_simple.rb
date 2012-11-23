#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_industrial_quad_relay'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'xyz' # Change to your UID

ipcon = IPConnection.new HOST, PORT # Create IP connection to brickd
iqr = BrickletIndustrialQuadRelay.new UID # Create device object
ipcon.add_device iqr # Add device to IP connection
# Don't use device before it is added to a connection

# Turn relays alternating on/off for 10 times with 100ms delay
for i in 0..9
  sleep 0.1
  iqr.set_value 1 << 0
  sleep 0.1
  iqr.set_value 1 << 1
  sleep 0.1
  iqr.set_value 1 << 2
  sleep 0.1
  iqr.set_value 1 << 3
end

puts 'Press key to exit'
$stdin.gets
ipcon.destroy
