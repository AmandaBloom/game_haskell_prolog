/* These rules describe current location */

where :-
        current_room(Room, Floor),
        write(Room),
        write(' | '),
        write(Floor).

floor :-
        current_room(_, Floor),
        writeln(Floor).

floor(Room) :-
        floor(Room, Floor),
        writeln(Floor).


/* These rules describe where a character can go */
% TODO guess a better function name
check_paths :-
        writeln('Paths found:'),
        check_paths_r.

check_paths_r :-
        current_room(X, _),
        (path(Y, X); path(X, Y)),
        format('\t -~s', [Y]),
        fail.
check_paths_r.

/* This rule defines short cut to call check_paths/0 */

cp :-
        check_paths.

/* This rule descibes how to go to another room */

go(X) :-
        current_room(Y, _),
        once((path(Y, X); path(X, Y))),
        retract(current_room(_, _)),
        floor(X, Z),
        assert(current_room(X, Z)),
        format('Welcome to the ~s', [X]), !.

go(_) :-
        write('I you cannot go there').
