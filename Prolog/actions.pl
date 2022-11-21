/* These rules describe how to pick up an object. */

take(X) :-
        timer_check,
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
        timer_check,
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
        timer_check,
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
        timer_check,
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


/* This rule describes how to check items around */

look :-
        timer_check,
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
        timer_check,
        fail.

inspect(doormat) :-
        describe(doormat),
        writeln('Here is a key. Shall i pick it up?'),
        assert(in(zinc_key, doormat)), !.

inspect(hole) :-
        describe(hole),
        retract(behind(hole, carpet)),
        assert(passage(room3, hole)), !.

inspect(X) :-
	describe(X), !.


/* This rule describe how to move objects */

move(X) :-
        timer_check,
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
        assert(picture(onfloor)),
        writeln('I removed this shame from the wall!'),
	assert(at(case, room4)), !.

move(carpet) :-
        writeln('Never thought it is so heavy.'),
        assert(behind(hole, carpet)), !.

move(_) :-
        writeln('I cant move it'), !.


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

open(fiberboard_door) :-
        timer_check,
        writeln('Locked.'),
        change_title(oak_door, 'fiberboard_door (locked)').

open(fridge) :-
        timer_check,
        locked(fridge),
        writeln('Frigde doors are locked, but there is no keyhole.\nIt is supposed to be using electromagnetic lock.'),
        change_title(fridge, 'fridge (locked)'), !.

open(fridge) :-
        change_title(fridge, 'fridge (opened)'),
        writeln('Here is a key. Never thought key should be stored at specific temperature.'),
        in(key, fridge), !.

open(case) :-
        writeln('Enter PIN please - open(case, PIN).'), !.

open(_) :- writeln('Not sure if it is possible to open it.'), !.

open(case, 1337) :-
        retract(locked(case)),
        assert(in(laptop, case)),
        writeln('*click*'), !.

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
