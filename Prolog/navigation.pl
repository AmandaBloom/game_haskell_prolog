/* These rules describe current location */

where :-
        timer_check,
        current_room(Room, Floor),
        write(Room),
        write(' | '),
        write(Floor).

floor :-
        timer_check,
        current_room(_, Floor),
        writeln(Floor).

floor(Room) :-
        timer_check,
        floor(Room, Floor),
        writeln(Floor).


/* These rules describe where a character can go */
find_passages :-
        timer_check,
        writeln('From here you cat go to:'),
        find_passages_r.

find_passages_r :-
        current_room(X, _),
        (passage(Y, X); passage(X, Y)),
        format('\t -~s\n', [Y]),
        fail.
find_passages_r.

/* This rule defines short cut to call find_passages/0 */

fp :-
        find_passages.

/* This rule descibes how to go to another room */

go(X) :-
        timer_check,
        current_room(Y, _),
        once((passage(Y, X); passage(X, Y))),
        retract(current_room(_, _)),
        floor(X, Z),
        assert(current_room(X, Z)),
        format('Welcome to the ~s\n\n', [X]),
        look.

go(_) :-
        writeln('I you cannot go there').
