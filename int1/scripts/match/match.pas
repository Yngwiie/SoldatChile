const
HOST='http://131.221.32.238/mreporter/api/setData/3/scl/';

procedure guardarStat();
var
	datos: string;
	recive :  String; 
	encod :  String; 
	fecha: string;
begin
  fecha:= FormatDate('yyyymmddhhnnss');
  datos:= ReadFile('logs/gamestat.txt');
  encod:=HTTPEncode(datos);
  recive:=GetURL( HOST + 'juego/' + fecha + '?data=' + encod) ; 

  WriteFile('logs/' + FormatDate('yyyymmdd') + '/' + fecha,datos);
  WriteConsole(0,recive,$00ff00);
end;

 
procedure OnGameEnd();
begin
  if CurrentMap <> 'Lobby'
  then 
    guardarStat();
end;

function OnCommand(ID: Byte; Text: string): boolean;
var
	datos: string;
	recive :  String;
begin
    if ContainsString(Text,'/mr ') then begin
       datos:=StrReplace(Text, '/mr ', '');
	   recive:=GetURL( HOST + 'partido/' + datos); 
	   WriteConsole(0,recive,$00ff00);
    end;
    Result := false; // Return true if you want to ignore the command typed.
end;