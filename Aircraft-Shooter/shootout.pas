Program	shootout;
Uses	crt,mouse;
Var	event:Tmouseevent;
	boompos,i,j,mouseX,ns,score,x,xplane,y,yplane,xpos,ypos:integer;
Procedure boom;
begin
	gotoxy(x,y+1);
	write(' ');
	boompos:=xpos;
	for j:=1 to 7 do
	begin
		gotoxy(boompos,ypos);
		textcolor(red);
		write('*');
		textcolor(7);
		delay(100);
		boompos:=boompos+1;
	end;
	gotoxy(xpos,ypos);
	write('       ');
	delay(100);
	x:=0;
	y:=34;
	xplane:=2;
	score:=score+1;
end;
Procedure Plane;
begin
	gotoxy(xplane,yplane);
	delay(50);
	textcolor(green);
	write('<^==U=>');
	textcolor(7);
	If (xplane>1) then 
	begin
		gotoxy(xpos,ypos);
		write('       ');
	end; 
	If (xplane=2) and (xpos>0) then
	begin
		gotoxy(xpos,ypos);
		write('       ');
	end;
	xpos:=xplane;
	ypos:=yplane;
	ns:=random(2)+1;
	Case ns of
	1: yplane:=yplane+1;
	2: yplane:=yplane-1;
	end;
	If (yplane<3) then yplane:=4;
	If (yplane>15) then yplane:=14;
	xplane:=xplane+1;
	If xplane=93 then xplane:=2;
end;
Procedure Bullet;
begin
	If (x>0) then
	begin
		gotoxy(x,y);
		textcolor(yellow);
		write(chr(219));
		textcolor(7);
		If (y<>36) then 
		begin
			gotoxy(x,y+1);
			write(' ');
		end;
		y:=y-1;
	end;
	If y=0 then 
	begin
		gotoxy(x,1);
		write(' ');
		x:=0;
		y:=34;
	end;
end;
Begin
	RANDOMIZE;
	cursoroff;
	score:=0;
	x:=0;
	y:=34;
	xpos:=0;
	xplane:=3;
	yplane:=random(10)+1;
	InitMouse;
	repeat
		gotoxy(90,1);
		write('Score: ',score);
		if PollMouseEvent(event) then
		begin
			getmouseevent(event);
			mouseX:=GetMouseX;
			If (mouseX<95) then
			begin
				gotoxy(1,35);
				for i:=1 to (mouseX-4) do write(' ');
				write('__________');
				for i:=1 to (100-(mouseX+5)) do write (' ');
			end;
			If (getMouseButtons=1) and (x=0) then x:=mouseX+2;
		end;
		Bullet;
		Plane;
		If (y+1=ypos+1) and (x>=xpos) and (x<=(xpos+6)) then boom;
		If (y+1=ypos) and (x>=xpos) and (x<=(xpos+6)) then boom;
	until 1=2;
End.