use std::{error::Error, io, thread, time::Duration};
use tinkerforge::{industrial_quad_relay_bricklet::*, ipconnection::IpConnection};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Industrial Quad Relay Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let industrial_quad_relay_bricklet = IndustrialQuadRelayBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    // Turn relays alternating on/off 10 times with 100 ms delay
    for i in 0..10 {
        thread::sleep(Duration::from_millis(100));
        industrial_quad_relay_bricklet.set_value(1 << 0);
        thread::sleep(Duration::from_millis(100));
        industrial_quad_relay_bricklet.set_value(1 << 1);
        thread::sleep(Duration::from_millis(100));
        industrial_quad_relay_bricklet.set_value(1 << 2);
        thread::sleep(Duration::from_millis(100));
        industrial_quad_relay_bricklet.set_value(1 << 3);
    }

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
