// Commands v0.1 for CTF
// Coded by KEEN - keen@soldat.com.ar
// http://www.soldat.com.ar/ - http://www.lasoldat.com/
// #soldat.arg #lasoldat @ Quakenet
// Solo otro script para soldat
// Con este script, tendrás algunos comandos en tu servidor

const 
ClMessage = $FFFF0000; 

var 
	Unpause1: boolean; 
	UnpauseCount1: integer; 
	Paused1: boolean; 
	SvPass: string;
 
 
procedure WriteMsg(ID: byte; msg: String; colour: longint); 
begin 
	if ID <> 255 then begin 
		WriteConsole(ID,msg,colour); 
	end 
	else WriteLn(msg); 
end; 
 
 
procedure WriteError(ID: byte; msg: String); 
begin 
	WriteMsg(ID,msg,$FFFF0000); 
end; 
 
 
procedure ActivateServer(); 
begin 
	Unpause1 := false; 
	UnpauseCount1 := 0; 
	Paused1 := false; 

	SvPass := '';
end; 
 
 
procedure OnPlayerSpeak(ID: Byte; Text: string); 
begin 
	if (GetPlayerStat(ID,'Team') = 5) then begin 
//		ERROR 
	end 
	else begin 
		if (LowerCase(Text)) = '!spec' then begin 
			Command('/setteam5 ' + IntToStr(ID)); 
		end 
		else 
		if (LowerCase(Text)) = '!s' then begin 
			Command('/setteam5 ' + IntToStr(ID)); 
		end 
		else 
		if (LowerCase(Text)) = '!r' then begin 
			Command('/restart'); 
			WriteConsole(0,'Reseteando mapa...',$EE81FAA1); 
		end 
		else 
		if (LowerCase(Text)) = '!nextmap' then begin 
			Command('/nextmap'); 
		end 
		else 
		if (LowerCase(GetPiece(Text,' ',0))) = '!map' then begin 
			Command('/map ' + GetPiece(Text,' ',1)); 
		end 
		else 
		if (LowerCase(Text)) = '!p' then begin 
			if Unpause1 = true then begin 
				Unpause1 := false; 
				UnpauseCount1 := 0; 
				WriteConsole(0,'>>>Cuenta regresiva cancelada.<<<',ClMessage); 
				WriteLn('>>>Cuenta regresiva cancelada.<<<'); 
			end; 
			if Paused1 = false then	begin 
				Paused1 := true; 
				Command('/pause'); 
			end; 
		end 
		else 
		if (LowerCase(Text)) = '!up' then begin 
			if Paused1 = true  then 
			begin 
				if Unpause1 = false then 
				begin 
					Unpause1 := true; 
					UnpauseCount1 := 3; 
					WriteConsole(0,'El juego continuará en...',ClMessage); 
					WriteLn('Go!!...'); 
				end; 
			end; 
		end 
	end; 
	if (LowerCase(Text)) = '!commands' then begin 
			WriteMsg(ID, '!a        --> Ingresar al Alpha.', $33FF00); 
			WriteMsg(ID, '!b        --> Ingresar al Bravo.', $33FF00); 
			WriteMsg(ID, '!spec     --> Ingresar como Espectador', $33FF00); 
			WriteMsg(ID, '!map XXX  --> Cambiar mapa: !map ctf_Ash', $33FF00); 
			WriteMsg(ID, '!nextmap  --> Proximo mapa.', $33FF00); 
			WriteMsg(ID, '!r        --> Resetear mapa.', $33FF00); 
			WriteMsg(ID, '!p        --> Pausa.', $33FF00); 
			WriteMsg(ID, '!up       --> Sacar pausa.', $33FF00);
			WriteMsg(ID, '!ub       --> Desbanear ultimo jugador.', $33FF00);
			WriteMsg(ID, '!pass XXX --> Cambiar contraseña: !pass 123', $33FF00); 
	end 
	else 
	if (LowerCase(Text)) = '!ub' then begin 
		Command('/unbanlast'); 
		WriteConsole(0,'Ultimo jugador desbaneado...',$EE81FAA1); 
	end 
	else 
	if (LowerCase(Text)) = '!a' then begin 
		Command('/setteam1 ' + IntToStr(ID)); 
	end 
	else 
	if (LowerCase(Text)) = '!b' then begin 
		Command('/setteam2 ' + IntToStr(ID)); 
	end 
	else
	if (LowerCase(GetPiece(Text,' ',0))) = '!pass' then begin 
		Command('/password ' + GetPiece(Text,' ',1));
		WriteConsole(0,'La contraseña de ingreso al servidor se ha cambiado a '  + GetPiece(Text,' ',1),$EE81FAA1); 
	end 
	else 
end; 
 
procedure AppOnIdle(Ticks: integer);  
begin  
	if (Unpause1 = true) then begin 
		if (UnpauseCount1 = 0) then begin 
			WriteConsole(0,'GO!',ClMessage); 
			WriteLn('GO!'); 
 
			Command('/unpause'); Command('/unpause'); Command('/unpause'); 
 
			UnpauseCount1 := 0; 
			Unpause1 := false; 
			Paused1 := false; 
    		end 
	else if (UnpauseCount1 > 0) then begin 
		WriteConsole(0,InttoStr(UnpauseCount1)+'...',ClMessage); 
		WriteLn(InttoStr(UnpauseCount1)+'...'); 
		UnpauseCount1 := UnpauseCount1 - 1; 
		end; 
  	end; 
end;

procedure OnLeaveGame(ID, Team: byte;Kicked: boolean);
begin
	UpdateGameStats; 
	if IntToStr(NumPlayers) = '1' then begin
	Command('/password ' + SvPass);
	end
end;
