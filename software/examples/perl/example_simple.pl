#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletIndustrialQuadRelay;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'igV'; # Change to your UID

my $ipcon = IPConnection->new(); # Create IP connection
my $iqr = BrickletIndustrialQuadRelay->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Turn relays alternating on/off for 10 times with 1000ms delay
for (my $i = 0; $i < 10; $i++)
{
    sleep(1);
    $iqr->set_value(1);
    
    sleep(1);
    $iqr->set_value(2);

    sleep(1);
    $iqr->set_value(4);

    sleep(1);
    $iqr->set_value(8);
}

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

