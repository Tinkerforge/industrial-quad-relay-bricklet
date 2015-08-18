#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletIndustrialQuadRelay;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $iqr = Tinkerforge::BrickletIndustrialQuadRelay->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Turn relays alternating on/off for 10 times with 100 ms delay
for (my $i = 0; $i < 10; $i++)
{
    select(undef, undef, undef, 0.1);
    $iqr->set_value(1);
    select(undef, undef, undef, 0.1);
    $iqr->set_value(2);
    select(undef, undef, undef, 0.1);
    $iqr->set_value(4);
    select(undef, undef, undef, 0.1);
    $iqr->set_value(8);
}

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

