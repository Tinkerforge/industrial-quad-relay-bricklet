var IPConnection = require('Tinkerforge/IPConnection');
var BrickletIndustrialQuadRelay = require('Tinkerforge/BrickletIndustrialQuadRelay');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'igV';// Change to your UID

var ipcon = new IPConnection();// Create IP connection
var iqr = new BrickletIndustrialQuadRelay(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        if(error === IPConnection.ERROR_ALREADY_CONNECTED) {
            console.log('Error: Already connected');        
        }
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Turn on first two relays and turn off last two relays
        ipcon.on(IPConnection.CALLBACK_CONNECTED,
            function(connectReason) {
                iqr.setValue(3);
            }
        );   
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data', function(data) {
	    ipcon.disconnect(
            function(error) {
                if(error === IPConnection.ERROR_NOT_CONNECTED) {
                    console.log('Error: Not connected');        
                }
            }
        );
process.exit(0);
});

