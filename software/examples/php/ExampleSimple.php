<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletIndustrialQuadRelay.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletIndustrialQuadRelay;

$host = 'localhost';
$port = 4223;
$uid = 'xyz'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$iqr = new BrickletIndustrialQuadRelay($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Turn relays alternating on/off for 10 times with 100 ms delay
for($i = 0; $i < 10; $i++)
{
    usleep(1000*100);
    $iqr->setValue(1 << 0);
    usleep(1000*100);
    $iqr->setValue(1 << 1);
    usleep(1000*100);
    $iqr->setValue(1 << 2);
    usleep(1000*100);
    $iqr->setValue(1 << 3);
}

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));

?>
