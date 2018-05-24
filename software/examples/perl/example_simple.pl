#!/usr/bin/perl

use strict;
use Tinkerforge::IPConnection;
use Tinkerforge::BrickletIndustrialQuadRelay;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Industrial Quad Relay Bricklet

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $iqr = Tinkerforge::BrickletIndustrialQuadRelay->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Turn relays alternating on/off 10 times with 100 ms delay
for (my $i = 0; $i < 10; $i++)
{
    select(undef, undef, undef, 0.1);
    $iqr->set_value(1 << 0);
    select(undef, undef, undef, 0.1);
    $iqr->set_value(1 << 1);
    select(undef, undef, undef, 0.1);
    $iqr->set_value(1 << 2);
    select(undef, undef, undef, 0.1);
    $iqr->set_value(1 << 3);
}

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
