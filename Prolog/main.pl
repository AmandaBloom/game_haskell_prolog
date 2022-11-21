/*<Agent Of Fortune Game> by Roman Ishchuk, Denys Savytskyi, Tomasz Pawlak*/

:- ensure_loaded(navigation).
:- ensure_loaded(timer).
:- ensure_loaded(descriptions).
:- ensure_loaded(actions).
:- ensure_loaded(init_load).

:- dynamic position/2, picture/1, holding/1, behind/2,  current_room/2, at/2, in/2, story_tell/1, passage/2,
        title/2, locked/1.
:- retractall(at(_, _)), retractall(current_room(_, _)), retractall(alive(_)), retractall(passage(_, _)),
        retractall(title(_, _)).


/* Tells the story connected with rooms*/

story_tell(hallway_ground_floor) :- writeln('Should I take a look at items here?').

story_tell(room1) :- writeln('Should I take a look at items here?').

story_tell(_) :- nl, !.

/* This rule enforce players to start game before performing an action */

check_alive :-
        alive(player),
        timer_check, !.

check_alive :-
        writeln('You should start the game first.'), !.


/* This rule describe how to leave house */

outside :-
        holding(laptop),
        writeln('Congratulation, Mission completed.'),
        tl,
        writeln('Enter "halt" to exit.'),
        retractall(alive(_)), !.


outside :-
        writeln('You had not found the laptop. Mission failed.'),
        die.

/* This rule describe how to change title of an object */

change_title(Obj, Title) :-
        retractall(title(Obj, _)),
        assert(title(Obj, Title)).


/* First panel in game telling the story */

introduction :-
        nl,
        writeln('Welcome Agent!. The world is a dangerous place. Mister Zero wants to make it'),
        writeln('even worse. Our intelligence has proven he has nuclear codes and he''s gonna'),
        writeln('use them to destroy The World. That''s why you were sent to his house. Search'),
        writeln('for the Laptop with codes and protect our future...'),
        writeln('Be quick, he is gonna come back in any time... '),
        writeln('.....'),
        writeln('..........'),
        write('...............Agent Of Fortune Game.....'), nl,
        write('..........'), nl,
        write('.....'), nl,
        write('Finally... You entered Mister Zero''s crib. Front door appears to be intact.'), nl,
        write('You''re into the hallway_ground_floor. On the small table there''s note - it says'),
        write('he will be back soon, so you have 10 minutes to leave the house, hurry up '), nl.



/* This rule tells how to die. */

die :-
        retractall(alive(_)),
        finish.

/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        writeln('The game is over.'),
        time_left,
        writeln('Available commands are:'),
        writeln('start. / s.                -- Restart the game.'),
        writeln('halt.                      -- Exit.'),
        abort, !.

/* This rule just writes out game instructions. */

help :-
        writeln('Enter commands using standard Prolog syntax.'),
        writeln('Available commands are:'),
        writeln('start. / s.                -- Start the game.'),
        writeln('go(Room)                   -- Enter the room.'),
        writeln('back. / b.                 -- Enter the previous room.'),
        writeln('find_passages. / fp.       -- Find available passages.'),
        writeln('take(Object). / t(O).      -- Pick up an object.'),
        writeln('drop(Object). / d(O).      -- Put down an object.'),
        writeln('inventory. / i.            -- Check invertory.'),
        writeln('look. / l.                 -- Look around you again.'),
        writeln('inspect(Object)            -- Look at smth in room'),
        writeln('open(Object)               -- Open at smth in room'),
        writeln('move(Object)               -- Move at smth in room'),
        writeln('turn_off(Object)           -- Turn smth off.'),
        writeln('press(Button)              -- Press the button.'),
        writeln('time_left / tl.            -- Сheck how much time is left'),
        writeln('help.                      -- See this message again.'),
        writeln('halt.                      -- End the game and quit.'),
	nl, !.


/* This rule prints out instructions and tells where you are. */

start :-
        init_load,
        start_timer(600000),
        introduction,
        help,
        look.

/* This rule defines short cut for start */

s :-
        start.
