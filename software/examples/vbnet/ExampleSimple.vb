Imports Tinkerforge

Module ExampleSimple
    Const HOST As String = "localhost"
    Const PORT As Integer = 4223
    Const UID As String = "XYZ" ' Change to your UID

    Sub Main()
        Dim ipcon As New IPConnection() ' Create IP connection
        Dim iqr As New BrickletIndustrialQuadRelay(UID, ipcon) ' Create device object

        ipcon.Connect(HOST, PORT) ' Connect to brickd
        ' Don't use device before ipcon is connected

        ' Turn relays alternating on/off for 10 times with 100 ms delay
        Dim i As Integer

        For i = 1 To 10
            System.Threading.Thread.Sleep(100)
            iqr.SetValue(1 << 0)
            System.Threading.Thread.Sleep(100)
            iqr.SetValue(1 << 1)
            System.Threading.Thread.Sleep(100)
            iqr.SetValue(1 << 2)
            System.Threading.Thread.Sleep(100)
            iqr.SetValue(1 << 3)
        Next i

        System.Console.WriteLine("Press key to exit")
        System.Console.ReadLine()
        ipcon.Disconnect()
    End Sub
End Module
