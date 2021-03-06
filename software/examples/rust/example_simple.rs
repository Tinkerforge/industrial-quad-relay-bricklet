use std::{error::Error, io, thread, time::Duration};
use tinkerforge::{industrial_quad_relay_bricklet::*, ip_connection::IpConnection};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Industrial Quad Relay Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let iqr = IndustrialQuadRelayBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Turn relays alternating on/off 10 times with 100 ms delay
    for _i in 0..10 {
        thread::sleep(Duration::from_millis(100));
        iqr.set_value(1 << 0).recv()?;
        thread::sleep(Duration::from_millis(100));
        iqr.set_value(1 << 1).recv()?;
        thread::sleep(Duration::from_millis(100));
        iqr.set_value(1 << 2).recv()?;
        thread::sleep(Duration::from_millis(100));
        iqr.set_value(1 << 3).recv()?;
    }

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
