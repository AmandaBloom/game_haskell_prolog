/*<Agent Of Fortune Game> by Roman Ishchuk, Denys Savytskyi, Tomasz Pawlak*/

:- ensure_loaded(navigation).
:- ensure_loaded(timer).

:- dynamic position/2, holding/1, current_room/2, at/2, in/2, story_tell/1, passage/2, title/2, key/1, locked/1.
:- retractall(at(_, _)), retractall(current_room(_, _)), retractall(alive(_)), retractall(passage(_, _)), retractall(title(_, _)),
        retractall(key(_)).

locked(fridge).

% at(thing, someplace).
/* hallway_ground_floor */
at(old_chair, hallway_ground_floor).
at(car_keys, hallway_ground_floor).
at(doormat, hallway_ground_floor).
at(pine_door, hallway_ground_floor).
at(oak_door, hallway_ground_floor).

/* room1 */

at(wall_clock, room1).
at(sofa, room1).
at(fridge, room1).

/* room2 */

/* corridor_1_floor */

at(wardrobe, corridor_1_floor).

/* room2 */

at(carpet, room3).

/* room4 */

at(picture, room4).
at(table, room4).
at(armchair, room4).

behind(case, picture).

player_at(room1).

in(key, fridge).
in(laptop, case).

hidden(hole, carpet).


/* Describe floor where room is located */

floor(hallway_ground_floor, ground_floor).
floor(room1, ground_floor).
floor(room2, ground_floor).

floor(corridor_1_floor, first_floor).
floor(room3, first_floor).
floor(room4, first_floor).

/* Describe paths to rooms */

passage(hallway_ground_floor, room1).

passage(corridor_1_floor, room3).
passage(corridor_1_floor, room4).

current_room(hallway_ground_floor, ground_floor).

/* Tells the story connected with rooms*/

story_tell(hallway_ground_floor) :- writeln('Should I take a look at items here? - inspect(X)').

story_tell(room1) :- writeln('Should I take a look at items here? - inspect(X)').

story_tell(_) :- nl, !.

/* These rules describe how to pick up an object. */

take(X) :-
        timer_check,
        holding(X),
        writeln('You''re already holding it!'), !.

take(X) :-
        current_room(Place, _),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        format('You have picked the ~s\n', [X]), !.

take(X) :-
        player_at(Place),
        at(Object, Place),
        in(X, Object),
        retract(in(X, Object)),
        assert(holding(X)),
        format('You have picked the ~s\n', [X]), !.

take(fridge) :- 
        player_at(Place),
        at(fridge, Place),
        writeln('I cant take a fridge It''s too heavy'), !.  

take(_) :-
        writeln('I don''t see it here.'), !.

/* This rule defines short cut for take */

t(X) :-
        take(X).

/* These rules describe how to put down an object. */

tell_objects_at(Place) :-
        timer_check,
        at(X, Place),
        write('We gotta '),
        (
                title(X, R) -> write(R)
        ;
                write(X)
        ),
        write(' in this place. '), nl,
        fail.

tell_objects_at(_).

turn_off(fridge) :-
	write('Oooooh noooo.... BoooooM.'), nl,
	die.

open_obj(X):-
	player_at(Place),
	at(X, Place),
	in(Object, X),
	write('There is '),
	write(Object),
	write(' in '),
	write(X), nl,
	inspect(Object),
	nl.

drop(X) :-
        timer_check,
        holding(X),
        current_room(Place, _),
        retract(holding(X)),
        assert(at(X, Place)),
        format('You have dropped the ~s\n', [X]),
        !.

drop(_) :-
        writeln('You aren''t holding it!'), !.

/* This rule defines short cut for drop/1 */

d(X) :-
        drop(X).

/* This rule write out content of invertory */

invertory :-
        timer_check,
        holding(_),
        invertory_r, !.

invertory :-
        write('You inventory in empty').

invertory_r :-
        holding(X),
        writeln(X),
        fail.
invertory_r.

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
        write('he will be back in 10 minutes, hurry up '), nl.

/* This rule defines short cut to call invertory  */

i :-
        invertory.

/* This rule describes how to check items around */

look :-
        timer_check,
	current_room(Place, _),
		describe(Place),nl,
                find_passages, nl,
		tell_objects_at(Place),
		story_tell(Place),
		nl, !.

look_around :-
        timer_check,
        current_room(X, _),
        at(_, X),
        writeln('Items here:'),
        look_around_r(X), !.

look_around :-
        writeln('There is nothing in here').

look_around_r(X) :-
        at(Y, X),
        write('\t - '),
        (
                title(Y, R) -> write(R)
        ;
                write(Y)
        ),
        nl,
        fail.
look_around_r(_).

/* This rule defines short cut for look_around */

la :-
        look_around.

/* Take a look at object */

inspect(doormat) :-
        timer_check,
        describe(doormat),
        writeln('Here is a key. Shall i pick i up? - take(X)'),
        assert(at(zinc_key, hallway_ground_floor)), !.

inspect(X) :-
        timer_check,
	describe(X), !.


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

help :-
        writeln('Enter commands using standard Prolog syntax.'),
        writeln('Available commands are:'),
        writeln('start. / s.                -- Start the game.'),
        writeln('go(Room)                   -- Enter the room.'),
        writeln('find_passages. / fp.       -- Find available passages.'),
        writeln('take(Object). / t(O).      -- Pick up an object.'),
        writeln('drop(Object). / d(O).      -- Put down an object.'),
        writeln('inventory. / i.            -- Check invertory.'),
        writeln('look_around. / la.         -- Look around you again.'),
        writeln('inspect(Object)            -- Look at smth in room'),
        writeln('time_left / tl.            -- Сheck how much time is left'),
        writeln('help.                      -- See this message again.'),
        writeln('halt.                      -- End the game and quit.'),
	nl, !.


/* This rule prints out instructions and tells where you are. */

start :-
        start_timer(600000),
        introduction,
        help,
        assert(current_room(hallway_ground_floor, ground_floor)),
        look.

/* This rule defines short cut for start */

s :-
        start.

/* These rules describe the various rooms.  Depending on circumstances, a room may have more than one description. */

describe(hallway_ground_floor) :-
        writeln('I''m in hallway_ground_floor'),
        writeln('What a long corridor. For a long time Mister Zero hasn''t done cleaning here.'),
        writeln('What huge spiders are sitting on the ceiling'), !.

describe(old_chair) :-
		writeln('Looks like he likes old things, but he doesn''t take care of them. Very well...').

describe(car_keys) :-
		writeln('Nice ... Besides being a villain, he also has a taste for cars. It''s like'),
		writeln('a code written at the belt - 1337. It may help me sometime. Car alarm system '),
                writeln('system pilot has 2 unlabeled buttons.'),
                writeln('I definitely shouldn''t use it. (press(left_button|/right_button)'), !.

describe(room1) :-
        write('You are in the first room. Damn, the door to the next room is closed'), nl,
        write('I have to find the key to the door to open the door to the second room.'), nl, !.

describe(room2) :- write('It''s so empty here, like after a robbery'), nl, !.

describe(corridor_1_floor) :-
        at(wardrobe, corridor_1_floor),
        write('Ooooh no, a big wardrobe is right in my path'), nl, !.

describe(corridor_1_floor) :-
        write('Oooh, now I can move on'), nl, !.

describe(room3) :- writeln(''), !.

describe(room4) :-
        write('Small room.'), nl,
        write('There was a work table and an armchair in the room, and a picture hung on the wall.'), nl, !.

describe(fridge) :- writeln('Oooh, it''s time to update this old refrigerator. Buzzing like a plane on the runway'), !.

describe(sofa) :- writeln('What an old shabby sofa. How can you sit on it?'), !.

describe(key) :- writeln('Yes, it''s a key.'), !.

describe(wardrobe) :- writeln('A large oak wardrobe closes the passage to the rooms on the 2nd floor'), !.

describe(carpet) :- writeln('Great modern carpet. The truth does not fit into the interior of the house a little'), !.

describe(armchair) :- writeln('A chair is like a chair. lol what else to say'), !.

describe(picture) :- writeln('The picture was kind of weird. This was a screenshot of the top 13 in PUBG solo'), !.

describe(case) :-
        in(laptop, case),
        writeln('You found a case!'), !.

describe(laptop) :- writeln('Eeeee, I found! - take(laptop)'), !.

describe(pine_door) :- writeln('A pine door with a big glass panel. Shall i try opening it? - open(X)'), !.

describe(oak_door) :- writeln('A Massive internal oak door. Shall i try opening it? - open(X)'), !.

describe(doormat) :- writeln('Good old welcome doormat.'), !.

describe(_) :- writeln('It smells like 404 to me. Something went wrong.'), !.

/* This rule describe how to move objects */

move(_) :-
        timer_check,
        fail.

move(wardrobe) :-
        writeln('Oh, it is moving.'),
        writeln('Here are doors!'),
        assert(passage(corridor_1_floor, room3)),
        assert(passage(corridor_1_floor, room4)),
        retract(at(wardrobe, corridor_1_floor)), nl,
        inspect(corridor_1_floor).

move(_) :-
        writeln('I cant move it').

/* These rules describe how to open smth  */

open(pine_door) :-
        timer_check,
        writeln('creeeeeek...'),
        assert(passage(hallway_ground_floor, room2)),
        retract(at(pine_door, hallway_ground_floor)), !.

open(oak_door) :-
        timer_check,
        holding(zinc_key),
        writeln('oak_door is opened now'),
        assert(passage(hallway_ground_floor, corridor_1_floor)),
        retract(at(oak_door, hallway_ground_floor)), !.

open(oak_door) :-
        timer_check,
        writeln('Seems like it is locked. I need a key.'),
        change_title(oak_door, 'oak_door (locked)').

open(fridge) :-
        timer_check,
        locked(fridge),
        writeln('Frigde doors are locked, but there is no keyhole.\nIt is supposed to be using electromagnetic lock.'),
        change_title(fridge, 'fridge (locked)'), !.

open(fridge) :-
        change_title(fridge, 'fridge (opened)'),
        writeln('Here is a key. Never thought key should be stored at specific temperature.'), !.

open(_) :- writeln('Not sure if it is possible to open it.'), !.

/* These rules describe how to press buttons */

press(left_button) :-
        timer_check,
        once(current_room(hallway_ground_floor, ground_floor)),
        writeln('Shhh..... Alarm has turned on. Cops will arrive in 5 minutes'),
        reduce_timer_to(300000), !.

press(right_button) :-
        timer_check,
        once(current_room(hallway_ground_floor, ground_floor)),
        writeln('*click*'),
        retract(locked(fridge)), !.

press(_) :-
        timer_check,
        fail.

o(X) :-
        open(X), !.

change_title(Obj, Title) :-
        retractall(title(Obj, _)),
        assert(title(Obj, Title)).

