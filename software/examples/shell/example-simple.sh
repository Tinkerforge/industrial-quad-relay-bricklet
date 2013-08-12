#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# turn relay 0, 3 on and relay 1, 2 off: (1 << 0) | (1 << 3) = 9
tinkerforge call industrial-quad-relay-bricklet $uid set-value 9
