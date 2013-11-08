Program	TicTacToe;
Uses	crt;
Var	choice,coin,cursor,d,errorcode,exito,f,i,int,j,play,r,s,turns,x,y:integer;
	ch,exit,face:char;
	player1,player2,pic,round,side:string;
	icon: array[1..2] of string;
	score:array[1..2] of integer;
	oparray: array[1..2,1..5] of string;
	table: array[1..3,1..3] of string;

Procedure FPP;
begin
	repeat
		cursoron;
		clrscr;
		writeln('--------------------------------------------------------------------------------');
		gotoxy(35,2);
		writeln('Coin Toss');
		gotoxy(35,3);
		writeln('---------');
		gotoxy(1,24);
		write('--------------------------------------------------------------------------------');
		gotoxy(4,5);
		write(player1,', pick ''heads''(H) or ''tails''(T): ');
		readln(side);
		If (side<>'H') and (side<>'T') then
		begin
			cursoroff;
			gotoxy(4,7);
			writeln('You did not enter the letter ''H'' or ''T''.');
			gotoxy(4,8);
			writeln('Please enter one of those letters.  Press any key to try again.');
			readkey;
		end;
	until (side='H') or (side='T');
	cursoroff;
	coin:=random(10) MOD 2;
	If coin=0 then face:='H' else face:='T';
	gotoxy(39,9);
	write('___');
	gotoxy(38,10);
	write('/   \');
	gotoxy(38,11);
	write('|   |');
	gotoxy(38,12);
	write('\___/');
	For i:=1 to 20 do
	begin
		gotoxy(40,11);
		write('T');
		delay(100);
		gotoxy(40,11);
		write('H');
		delay(100);
	end;
	For i:=1 to 10 do
	begin
		gotoxy(40,11);
		write('T');
		delay(150);
		gotoxy(40,11);
		write('H');
		delay(150);
	end;
	For i:=1 to 5 do
	begin
		gotoxy(40,11);
		write('T');
		delay(400);
		gotoxy(40,11);
		write('H');
		delay(400);
	end;
	gotoxy(40,11);
	write(face);
	delay(700);
	gotoxy(4,15);
	If face=side then 
	begin
		write(player1,' will go first.');
		play:=1;
	end
	else 
	begin
		write(player2,' will go first');
		play:=2;
	end;
	delay(2000);
	gotoxy(4,20);
	write('Press any key to continue');
	readkey;
	clrscr;
end;

Procedure IconPlacement(a,b:integer);
begin
	a:=((a-34) DIV 6)+1;
	b:=((b-6) DIV 6)+1;
	If (table[a,b]<>' ') then
	begin
		gotoxy(3,4);
		write('This icon has been chosen.');
		gotoxy(3,5);
		write('Please choose a different icon.');
		choice:=0;
	end
	else
	begin
		If play=1 then table[a,b]:=icon[1] else table[a,b]:=icon[2];		
		choice:=1;
	end;
end;

Procedure tableprint;
Begin
	For i:=0 to 2 do
		for j:=0 to 2 do
		begin
		gotoxy(34+(i*6),6+(j*6));
		write(table[i+1,j+1]);
		end;
end;

Procedure turnproc;
begin
	gotoxy(3,3);
	x:=34;
	y:=6;
	If play=1 then 
	begin
	write(Player1,', choose your position');
	pic:=icon[1];
	gotoxy(x,y);
	write(icon[1]);
	end
		  else
	begin
	write(Player2,', choose your position');
	pic:=icon[2];
	gotoxy(x,y);
	write(icon[2]);
	end;
	repeat
		ch:=readkey;
		Case ch of
			chr(72):If y=6 then
				begin
					gotoxy(x,6);
					write(' ');
					tableprint;
					gotoxy(x,18);
					write(pic);
					y:=18;
				end
			    else
				begin
					gotoxy(x,y);
					write(' ');
					tableprint;
					gotoxy(x,y-6);
					write(pic);
					y:=y-6;
				end;
			chr(80):If y=18 then
				begin
					gotoxy(x,18);
					write(' ');
					tableprint;
					gotoxy(x,6);
					write(pic);
					y:=6;
				end
			    else
				begin
					gotoxy(x,y);
					write(' ');
					tableprint;
					gotoxy(x,y+6);
					write(pic);
					y:=y+6;
				end;
			chr(75):If x=34 then
				begin
					gotoxy(34,y);
					write(' ');
					tableprint;
					gotoxy(46,y);
					write(pic);
					x:=46;
				end
			    else
			        begin
			        	gotoxy(x,y);
			        	write(' ');
			        	tableprint;
			        	gotoxy(x-6,y);
			        	write(pic);
			        	x:=x-6;
			        end;
			chr(77):If x=46 then
				begin
					gotoxy(46,y);
					write(' ');
					tableprint;
					gotoxy(34,y);
					write(pic);
					x:=34;
				end
			    else
			        begin
			        	gotoxy(x,y);
			        	write(' ');
			        	tableprint;
			        	gotoxy(x+6,y);
			        	write(pic);
			        	x:=x+6;
			        end;
			chr(13): IconPlacement(x,y);
		end;
	until (ch=chr(13)) and (choice=1);
	choice:=0;
end;

Procedure decider;
begin
	If play=2 then 
	begin
		gotoxy(3,15);
		write('Congrats ',player1,', YOU WIN THIS ROUND!');
		gotoxy(3,16);
		write('Press any key to proceed to the next round.');
		score[1]:=score[1]+1;
		r:=11;
		readkey;
	end
		  else
	begin
		gotoxy(3,15);
		write('Congrats ',player2,', YOU WIN THIS ROUND!');
		gotoxy(3,16);
		write('Press any key to proceed to the next round.');
		score[2]:=score[2]+1;
		readkey;
		r:=11;
	end;
	For i:=1 to 3 do
		for j:=1 to 3 do table[i,j]:=' ';
end;

Procedure game;
begin
	FPP;
	For turns:=1 to int do
	begin
	r:=1;
		while r<10 do
		begin
			For i:=0 to 2 do
				for j:=0 to 2 do
				begin
					gotoxy(34+(i*6),6+(j*6));
					write(table[i+1,j+1]);
				end;
			gotoxy(1,1);
			write('Game: ',turns,'          ','Score: ',player1,': ',score[1],'  ',player2,': ',score[2]);
			gotoxy(31,9);
			write('------------------');
			gotoxy(31,15);
			write('------------------');
			for i:=0 to 18 do
			begin
				gotoxy(37,3+i);
				write('|');
			end;
			for i:=0 to 18 do
			begin
				gotoxy(43,3+i);
				write('|');
			end;
			gotoxy(3,3);
			If play=1 then 
			begin
				turnproc;
				play:=2;
			end
			           else 
			begin
				turnproc;
				play:=1;
			end;
			r:=r+1;
			For s:=1 to 3 do
			begin
				If (table[s,1]=table[s,2]) and (table[s,2]=table[s,3]) and (table[s,3]=icon[(play MOD 2)+1]) then decider else
				If (table[1,s]=table[2,s]) and (table[2,s]=table[3,s]) and (table[3,s]=icon[(play MOD 2)+1]) then decider else
				If (table[1,1]=table[2,2]) and (table[2,2]=table[3,3]) and (table[3,3]=icon[(play MOD 2)+1]) then decider else
				If (table[3,1]=table[2,2]) and (table[2,2]=table[1,3]) and (table[1,3]=icon[(play MOD 2)+1]) then decider else
				If r=10 then 
				begin
					gotoxy(3,15);
					If turns=int then write('No player has won this round.  Let''s see who won the game!') else
					write('No player has won this round.  We will go to the next round');
					For i:=1 to 3 do
						for j:=1 to 3 do table[i,j]:=' ';
					r:=11;
					readkey;
				end;
			end;
			clrscr;
		end;
	end;
	writeln('--------------------------------------------------------------------------------');
	gotoxy(35,2);
	writeln('End Result');
	gotoxy(35,3);
	writeln('----------');
	gotoxy(1,24);
	write('--------------------------------------------------------------------------------');
	gotoxy(4,6);
	If score[1]>score[2] then write(Player1,', YOU WON TIC TAC TOE!  CONGRAGULATIONS!') else
	If score[1]<score[2] then write(Player2,', YOU WON TIC TAC TOE!  CONGRAGULATIONS!') else
	write('There was a tie!  You should probably play this game to settle a winner...');
	gotoxy(4,7);
	write('Press any key to return to the menu');
	readkey;
	clrscr;
end;
	
Procedure Instructions;
begin
	clrscr;
	writeln('--------------------------------------------------------------------------------');
	gotoxy(35,2);
	writeln('Instructions');
	gotoxy(4,4);
	writeln('Objective:'); 
	writeln('   The player who succeeds in placing three respective marks in a');
	writeln('   horizontal, vertical, or diagonal row wins the game.');
	writeln('');
	writeln('   Controls:');
	writeln('   Use the up, down, left and right arrow keys to move.');
	writeln('   Press ''enter'' to confirm your choice.');
	writeln('');
	writeln('   Procedure:');
	writeln('   You can go to the Options menu to choose the player names, number of'); 
	writeln('   rounds and the type of icons you want to make your marks with.');
	writeln('   If you do not change any options, the default settings will be used,');
	writeln('   and only 3 rounds of tic tac toe will be played.');   
	writeln('   The player with the most rounds won wins the game!');
	writeln('');                          
	writeln('');
	writeln('   May the odds be ever in your favor...');
	gotoxy(1,24);
	write('--------------------------------------------------------------------------------');
	gotoxy(1,22);
	writeln('   Press any key to return to the menu');
	readkey;
	clrscr;
end;

Procedure Players;
begin
	cursoron;
	clrscr;
	writeln('--------------------------------------------------------------------------------');
	gotoxy(35,2);
	writeln('Players');
	gotoxy(1,24);
	write('--------------------------------------------------------------------------------');
	gotoxy(4,4);
	write('Enter Player 1''s Name: ');
	readln(player1);
	gotoxy(4,5);
	write('Enter Player 2''s Name: ');
	readln(player2);
	cursoroff;
	gotoxy(4,8);
	write('Press any key to go back to the options menu');
	readkey;
	clrscr;
end;
	
Procedure Rounds;
begin
	repeat
		cursoron;
		clrscr;
		writeln('--------------------------------------------------------------------------------');
		gotoxy(35,2);
		writeln('Number of Rounds');
		gotoxy(1,24);
		write('--------------------------------------------------------------------------------');
		gotoxy(4,4);	
		write('How many rounds do you want to have?: ');
		readln(round);
		cursoroff;
		VAL(round,int,errorcode);
		If errorcode>0 then 
		begin
			gotoxy(4,8);
			write('ERROR: You did not enter an integer.  Please enter a whole number.'); 
			gotoxy(4,9);
			write('       Press any key to try again');
			readkey;
			clrscr;
		end
		else if int<0 then
		begin
			gotoxy(4,8);
			write('ERROR: You did not enter a positive number of rounds.');
			gotoxy(4,9);
			write('       Please enter a postive number of rounds.  Press any key to try again');
			readkey;
			clrscr;
		end;
	until (errorcode=0) and (int>0);
end;

Procedure Iconassignment(x:integer);
begin
	x:=((cursor-14) DIV 13)+1;
	If oparray[2,x]=' ' then
	begin
		gotoxy(4,15);
		write('This icon has been chosen by ',player1,'.');
		gotoxy(4,16);
		write('Please choose a different icon.');
		choice:=0;
	end
	else
	begin
		icon[j]:=oparray[2,x];
		oparray[2,x]:=' ';
		choice:=1;
	end;
end;

Procedure Icons;
begin
	For j:=1 to 2 do
	begin
		clrscr;
		writeln('--------------------------------------------------------------------------------');
		gotoxy(35,2);
		writeln('Icon Choices');
		gotoxy(1,24);
		write('--------------------------------------------------------------------------------');
		gotoxy(4,4);	
		write('Choose which icon you want to play with:');
		gotoxy(13,11);
		For i:=1 to 5 do write(oparray[1,i],'          ');
		gotoxy(14,13);
		For i:=1 to 5 do write(oparray[2,i],'            ');
		gotoxy(14,11);
		write('X');
		gotoxy(2,23);
		write('Use left and right arrow keys to move and ''enter'' to confirm your choice');
		cursor:=14;
		gotoxy(4,6);
		If j=1 then write(player1,', pick your icon: ')
		else write(player2,', pick your icon: ');
		repeat
			ch:=readkey;
			Case ch of
				chr(75):If cursor=14 then
					begin
						gotoxy(14,11);
						write(' ');
						gotoxy(66,11);
						write('X');
						cursor:=66;
					end
				    else
					begin
						gotoxy(cursor,11);
						write(' ');
						gotoxy(cursor-13,11);
						write('X');
						cursor:=cursor-13;
					end;
				chr(77):If cursor=66 then
					begin
						gotoxy(66,11);
						write(' ');
						gotoxy(14,11);
						write('X');
						cursor:=14;
					end
				    else
					begin
						gotoxy(cursor,11);
						write(' ');
						gotoxy(cursor+13,11);
						write('X');
						cursor:=cursor+13;
					end;
				chr(13): Iconassignment(cursor);
			end;
		until (ch=chr(13)) and (choice=1);
		choice:=0;
	end;
	gotoxy(cursor,13);
	write(' ');
	gotoxy(4,18);
	write('Good choices!  Press any key to go back to the options menu!');
	readkey;
	oparray[2,1]:='@';		
	oparray[2,2]:='#';
	oparray[2,3]:='$';
	oparray[2,4]:='X';
	oparray[2,5]:='O';
	clrscr;
end;

Procedure Options;
begin
	clrscr;
	cursor:=4;
	writeln('--------------------------------------------------------------------------------');
	gotoxy(35,2);
	writeln('Options');
	gotoxy(4,4);
	writeln('[X]  Players');
	gotoxy(4,5);
	writeln('[ ]  Number of Rounds');
	gotoxy(4,6);
	writeln('[ ]  Icons');
	gotoxy(4,7);
	writeln('[ ]  Go back to Menu');
	gotoxy(2,23);
	write('Use up and down arrow keys to move and the ''enter'' key to confirm your choice');
	gotoxy(1,24);
	write('--------------------------------------------------------------------------------');
	repeat;
		ch:=readkey;
		Case ch of
			chr(72):If cursor=4 then
				begin
					gotoxy(4,4);
					write('[ ]');
					gotoxy(4,7);
					write('[X]');
					cursor:=7;
				end
			    else
				begin
					gotoxy(4,cursor);
					write('[ ]');
					gotoxy(4,cursor-1);
					write('[X]');
					cursor:=cursor-1;
				end;
			chr(80):If cursor=7 then
				begin
					gotoxy(4,7);
					write('[ ]');
					gotoxy(4,4);
					write('[X]');
					cursor:=4;
				end
			    else
				begin
					gotoxy(4,cursor);
					write('[ ]');
					gotoxy(4,cursor+1);
					write('[X]');
					cursor:=cursor+1;
				end;
			chr(13): If cursor=4 then Players else if cursor=5 then Rounds else if cursor=6 then Icons else if cursor=7 then exito:=1;
		end;
	until ch=chr(13);
	clrscr;
end;

Procedure menu;
	begin	
		cursor:=12;
		writeln('--------------------------------------------------------------------------------');
		gotoxy(1,24);
		write('--------------------------------------------------------------------------------');
		gotoxy(31,3);
		writeln('WELCOME TO TIC-TAC-TOE!');
		gotoxy(36,12);
		writeln('[X]  New Game');
		gotoxy(36,13);
		writeln('[ ]  Instructions');
		gotoxy(36,14);
		writeln('[ ]  Options');
		gotoxy(36,15);
		writeln('[ ]  Quit');
		gotoxy(2,23);
		write('Use up and down arrow keys to move and the ''enter'' key to confirm your choice');
		repeat
			ch:=readkey;
			Case ch of
			chr(72):If cursor=12 then
				begin
					gotoxy(36,12);
					write('[ ]');
					gotoxy(36,15);
					write('[X]');
					cursor:=15;
				end
			    else
				begin
					gotoxy(36,cursor);
					write('[ ]');
					gotoxy(36,cursor-1);
					write('[X]');
					cursor:=cursor-1;
				end;
			chr(80):If cursor=15 then
				begin
					gotoxy(36,15);
					write('[ ]');
					gotoxy(36,12);
					write('[X]');
					cursor:=12;
				end
			    else
				begin
					gotoxy(36,cursor);
					write('[ ]');
					gotoxy(36,cursor+1);
					write('[X]');
					cursor:=cursor+1;
				end;
			chr(13): If cursor=12 then game else if cursor=13 then instructions else if cursor=14 then 
			begin
				repeat
				options;
				until exito=1;
				exito:=0;
			end
			else if cursor=15 then exit:='q';
			end;
		until ch=chr(13);
	end;
Begin
	randomize;
	cursoroff;
	player1:='Player 1';
	player2:='Player 2';
	exit:='e';
	int:=3;
	For i:=1 to 5 do oparray[1,i]:='[ ]';
	oparray[2,1]:='@';
	oparray[2,2]:='#';
	oparray[2,3]:='$';
	oparray[2,4]:='X';
	oparray[2,5]:='O';
	icon[1]:=oparray[2,4];
	icon[2]:=oparray[2,5];
	score[1]:=0;
	score[2]:=0;
	For i:=1 to 3 do
		for j:=1 to 3 do table[i,j]:=' ';	
	repeat
	menu;	
	until exit='q';
	gotoxy(1,23);
End.
	
 