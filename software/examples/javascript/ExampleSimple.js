var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var iqr = new Tinkerforge.BrickletIndustrialQuadRelay(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Turn relays alternating on/off 10 times with 100 ms delay
        for(var i = 0; i < 10; ++i) {
            setTimeout(function () {
                iqr.setValue(1 << 0);
            }, 400 * i + 100);
            setTimeout(function () {
                iqr.setValue(1 << 1);
            }, 400 * i + 200);
            setTimeout(function () {
                iqr.setValue(1 << 2);
            }, 400 * i + 300);
            setTimeout(function () {
                iqr.setValue(1 << 3);
            }, 400 * i + 400);
        }
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
