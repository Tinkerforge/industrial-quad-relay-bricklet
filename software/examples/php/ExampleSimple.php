<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletIndustrialQuadRelay.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletIndustrialQuadRelay;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'xyz'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$iqr = new BrickletIndustrialQuadRelay(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
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
$ipcon->disconnect();

?>
