
#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_industrial_quad_relay.h"

#define HOST "localhost"
#define PORT 4223
#define UID "xyz" // Change to your UID

int main() {
	// Create IP connection to brickd
	IPConnection ipcon;
	if(ipcon_create(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not create connection\n");
		exit(1);
	}

	// Create device object
	IndustrialQuadRelay iqr;
	industrial_quad_relay_create(&iqr, UID); 

	// Add device to IP connection
	if(ipcon_add_device(&ipcon, &iqr) < 0) {
		fprintf(stderr, "Could not connect to Bricklet\n");
		exit(1);
	}
	// Don't use device before it is added to a connection

	// Turn relay 0, 3 on and relay 1, 2 off.
	industrial_quad_relay_set_value(&iqr, 1 | 8);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon);
}
