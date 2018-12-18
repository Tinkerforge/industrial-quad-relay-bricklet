package main

import (
	"fmt"
	"github.com/tinkerforge/go-api-bindings/industrial_quad_relay_bricklet"
	"github.com/tinkerforge/go-api-bindings/ipconnection"
	"time"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Industrial Quad Relay Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	iqr, _ := industrial_quad_relay_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Turn relays alternating on/off 10 times with 100 ms delay
	for i := 0; i < 10; i++ {
		time.Sleep(100 * time.Millisecond)
		iqr.SetValue(1 << 0)
		time.Sleep(100 * time.Millisecond)
		iqr.SetValue(1 << 1)
		time.Sleep(100 * time.Millisecond)
		iqr.SetValue(1 << 2)
		time.Sleep(100 * time.Millisecond)
		iqr.SetValue(1 << 3)
	}

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
