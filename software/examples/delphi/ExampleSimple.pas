program ExampleSimple;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletIndustrialQuadRelay;

type
  TExample = class
  private
    ipcon: TIPConnection;
    iqr: TBrickletIndustrialQuadRelay;
  public
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'xyz'; { Change to your UID }

var
  e: TExample;

procedure TExample.Execute;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  iqr := TBrickletIndustrialQuadRelay.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(iqr);
  { Don't use device before it is added to a connection }

  { Turn relay 0, 3 on and relay 2, 3 off. }
  iqr.SetValue((1 shl 0) or (1 shl 3));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
