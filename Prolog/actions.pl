/* These rules describe how to pick up an object. */

/* This rule write out content of inventory */

inventory :-
        check_alive,
        holding(_),
        inventory_r, !.

inventory :-
        write('You inventory in empty').

inventory_r :-
        holding(X),
        writeln(X),
        fail.
inventory_r.


/* This rule defines short cut to call invertory  */

i :-
        inventory.


/* These rules describe how to take objects */

take(X) :-
        check_alive,
        holding(X),
        writeln('You''re already holding it!'), !.

take(X) :-
        (X=fridge; X=wardrobe),
        current_room(Place, _),
        at(X, Place),
        format('I cant take a ~s\n', [X]),
        writeln('It''s too heavy'), !.
		

take(X) :-
        current_room(Place, _),
        at(X, Place),
        retract(at(X, Place)),
        assert(holding(X)),
        format('You have picked the ~s\n', [X]), !.

take(X) :-
        current_room(Place, _),
        at(Object, Place),
        in(X, Object),
        retract(in(X, Object)),
        assert(holding(X)),
        format('You have picked the ~s\n', [X]), !.

take(_) :-
        writeln('I don''t see it here.'), !.

/* This rule defines short cut for take */

t(X) :-
        take(X).


/* These rules describe how to write out objects at place. */

tell_objects_at(Place) :-
        check_alive,
        at(X, Place),
        write('We gotta '),
        (
                title(X, R) -> write(R)
        ;
                write(X)
        ),
        write(' in this place. '), nl,
        tell_objects_in(X),
        tell_objects_behind(X),
        fail.

tell_objects_at(_).


/* These rules describe how to write out objects 'in' object. */

tell_objects_in(Obj) :-
        in(X, Obj),
        write('\tWe gotta '),
        (
                title(X, R) -> write(R)
        ;
                write(X)
        ),
        format(' in ~s.', [Obj]), nl,
        fail.

tell_objects_in(_).


/* These rules describe how to write out objects 'behind' object. */

tell_objects_behind(Obj) :-
        behind(X, Obj),
        write('\tWe gotta '),
        (
                title(X, R) -> write(R)
        ;
                write(X)
        ),
        format(' behind ~s.', [Obj]), nl,
        fail.

tell_objects_behind(_).

turn_off(fridge) :-
	write('Oooooh noooo.... BoooooM.'), nl,
	die.



/* These rules describe how to put down an object. */

drop(X) :-
        check_alive,
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


/* This rule describes how to check items around */

look :-
        check_alive,
		current_room(Place, _),
        describe(Place),nl,
        find_passages, nl,
        tell_objects_at(Place),
        story_tell(Place),
        nl, !.

/* This rule defines short cut to call look  */

l :-
        look, !.


/* Take a look at object */

inspect(_) :-
        check_alive, fail.

inspect(doormat) :-
        describe(doormat),
        writeln('Here is a zinc_key. Shall i pick it up?'),
        assert(in(zinc_key, doormat)), !.

inspect(hole) :-
        describe(hole),
        retract(behind(hole, carpet)),
        assert(passage(room3, hole)), !.
		
inspect(fridge) :-
		describe(fridge),
		writeln('Here is a key. Shall i pick it up?'),
        assert(in(key, fridge)), !.

inspect(X) :-
	describe(X), !.


/* This rule describe how to move objects */

move(X) :-
        check_alive,
        current_room(Y, _),
        at(X, Z),
        (Y==Z -> fail; !),
        writeln('Cannot find it here.'), !.

move(wardrobe) :-
        writeln('Oh, it is moving.'),
        writeln('Here is passage to another room, but no doors.!'),
        assert(passage(corridor_1_floor, room5)),
        change_title(wardrobe, 'wardrobe (moved)'), !.


move(picture) :-
        retract(picture(onwall)),
        writeln('I removed this shame from the wall! Hey, what''s this in the small gap in the wall'),
		assert(at(case, room4)), !.

move(carpet) :-
        writeln('Never thought it is so heavy.'),
        assert(behind(hole, carpet)), !.

move(_) :-
        writeln('I cant move it'), !.


/* These rules describe how to open smth  */

open(_) :-
        check_alive,
        fail.

open(pine_door) :-
        writeln('creeeeeek...'),
        assert(passage(hallway_ground_floor, room2)),
        retract(at(pine_door, hallway_ground_floor)), !.

open(oak_door) :-
        holding(zinc_key),
        writeln('oak_door is opened now'),
        assert(passage(hallway_ground_floor, corridor_1_floor)),
        retract(at(oak_door, hallway_ground_floor)), !.

open(oak_door) :-
        writeln('Seems like it is locked. I need a key.').
		/*change_title(oak_door, 'oak_door (locked)').*/

open(fiberboard_door) :-
        writeln('Locked. Maybe the lead to nowhere...'),
        change_title(oak_door, 'fiberboard_door (locked)').

open(fridge) :-
        locked(fridge),
        writeln('Frigde doors are locked, but there is no keyhole.\nIt is supposed to be using electromagnetic lock.'),
        change_title(fridge, 'fridge (locked)').

open(fridge) :-
        writeln('Here is a key. Never thought key should be stored at specific temperature.'),
        change_title(fridge, 'fridge (opened)'), !.
		

open(case) :-
        writeln('Enter PIN please - open(case, PIN).'), !.

open(_) :- writeln('Not sure if it is possible to open it.'), !.

open(_, _) :-
        check_alive,
        fail.

open(case, 1337) :-
        retract(locked(case)),
        assert(in(laptop, case)),
        writeln('*click*. There''s a laptop here!!! There''s my mission''s target!!!'),
		writeln('*** ACHTUNG ACHTUNG *** Alarm has turned on. Dr. Zero will arrive in a minute! RUN AGENT, RUN!!!'),
        reduce_timer_to(60000),
		
		describe(laptop), !.

open(case, 1337) :-
        assert(case_status(closed)),
        retract(case_status(closed)),
        writeln('Case is already open!'), !.

open(case, _) :-
        writeln('Beep-beep-beep'), !.

open(_, _) :- writeln('Not sure if it is possible to open it.'), !.

/* This rule defines short cut to call open */

o(X) :-
        open(X), !.


/* These rules describe how to press buttons */

press(_) :-
        check_alive,
        fail.

press(left_button) :-
        once(current_room(hallway_ground_floor, ground_floor)),
        writeln('Shhh..... Alarm has turned on. Cops will arrive in 5 minutes'),
        reduce_timer_to(300000), !.

press(right_button) :-
        once(current_room(hallway_ground_floor, ground_floor)),
        writeln('*click*'),
        retract(locked(fridge)), !.
