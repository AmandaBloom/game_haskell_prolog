:- ensure_loaded(navigation).

:- dynamic position/2, holding/1, current_room/2. at/2.
:- retractall(at(_, _)), retractall(current_room(_, _)), retractall(alive(_)), retractall(path(_, _)).

% at(thing, someplace).
at(obj1, room1).
at(sofa, room1).
at(fridge, room1).

in(key, fridge).


/* Describe floor where room is located */

floor(hallway_ground_floor, ground_floor).
floor(room1, ground_floor).
floor(room2, ground_floor).

floor(corridor_1_floor, first_floor).
floor(room3, first_floor).
floor(room4, first_floor).

/* Describe paths to rooms */

path(hallway_ground_floor, room1).
path(hallway_ground_floor, room2).

path(hallway_ground_floor, corridor_1_floor).

path(corridor_1_floor, room3).
path(corridor_1_floor, room4).

current_room(hallway_ground_floor, ground_floor).

/* These rules describe how to pick up an object. */

take(X) :-
        holding(X),
        write('You''re already holding it!'),
        !, nl.

take(X) :-
        current_room(Place, _),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        format('You have picked the ~s', [X]),
        !, nl.

take(_) :-
        write('I don''t see it here.'),
        nl.

/* This rule defines short cut for take/1 */

t(X) :-
        take(X).

/* These rules describe how to put down an object. */

drop(X) :-
        holding(X),
        current_room(Place, _),
        retract(holding(X)),
        assert(at(X, Place)),
        format('You have dropped the ~s', [X]),
        !, nl.

drop(_) :-
        write('You aren''t holding it!'),
        nl.

/* This rule defines short cut for drop/1 */

d(X) :-
        drop(X).

/* This rule write out content of invertory */

invertory :-
        holding(_),
        invertory_r.

invertory :-
        write('You inventory in empty').

invertory_r :-
        holding(X),
        writeln(X),
        fail.
invertory_r.

/* This rule defines short cut to call invertory/0 */

i :-
        invertory.

/* This rule describes how to check items around */

look_around :-
        current_room(X, _),
        at(_, X),
        writeln('Items here:'),
        look_around_r(X), !.

look_around :-
        writeln('There is nothing in here').

look_around_r(X) :-
        at(Y, X),
        format('\t -~s', [Y]),
        fail.
look_around_r(_).

/* This rule defines short cut for look_around/0 */

la :-
        look_around.

/* This rule tells how to die. */

die :-
        finish.

/* Under UNIX, the "halt." command quits Prolog but does not
   remove the output window. On a PC, however, the window
   disappears before the final output can be seen. Hence this
   routine requests the user to perform the final "halt." */

finish :-
        nl,
        write('The game is over. Please enter the "halt." command.'),
        nl.

/* This rule just writes out game instructions. */

instructions :-
        writeln('Enter commands using standard Prolog syntax.'),
        writeln('Available commands are:'),
        writeln('start. ( s. )                  -- to start the game.'),
        writeln('go(Room)                       -- to enter the room.'),
        writeln('take(Object). ( t(O). )        -- to pick up an object.'),
        writeln('drop(Object). ( d(O). )        -- to put down an object.'),
        writeln('inventory. ( i. )              -- to check invertory.'),
        % TODO writeln('look_around. ( la. )  -- to look around you again.'),
        writeln('instructions.                  -- to see this message again.'),
        writeln('halt.                          -- to end the game and quit.').


/* This rule prints out instructions and tells where you are. */

start :-
        instructions.

/* This rule defines short cut for start/0 */

s :-
        start,
        assert(current_room(hallway_ground_floor, ground_floor)).

/* These rules describe the various rooms.  Depending on
   circumstances, a room may have more than one description. */

describe(hallway_ground_floor) :- write('What a long corridor. For a long time we haven’t done cleaning here.'), nl.
        write('What huge spiders are sitting on the ceiling'), nl.

describe(room1) :- 
        at(sofa, room1),
        at(fridge, room1),
        write('You are in the first room. Damn, the door to the next room is closed'), nl.
        write('I have to find the key to the door to open the door to the second room.'), nl.

describe(room2) :- write('It''s so empty here, like after a robbery'), nl.

describe(corridor_1_floor) :- 
        write(''), nl.

describe(room3) :- write(''), nl.

describe(room4) :- write(''), nl.

description(fridge) :- write('Oooh, it''s time to update this old refrigerator. Buzzing like a plane on the runway'), !, nl.

description(sofa) :- write('What an old shabby sofa. How can you sit on it?'), !, nl.

describe(key) :- write('Yes, it''s a key.'), !, nl.

describe(case) :-
        at(laptop, case),
        write('You found a case!'), nl.

describe(case) :-
        write('The case has already been opened.'), nl.

