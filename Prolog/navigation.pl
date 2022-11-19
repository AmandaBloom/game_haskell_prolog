/* These rules describe current location */

:- dynamic passage_stack/1.
:- retractall(passage_stack(_)).

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
        current_room(Room, _),
        writeln('From here you cat go to:'),
        find_passages_r(Room), !.

find_passages_r(Room) :-
        (passage(Y, Room); passage(Room, Y)),
        format('\t - ~s\n', [Y]),
        fail.
find_passages_r(_).

/* This rule defines short cut to call find_passages/0 */

fp :-
        find_passages.

/* This rule descibes how to go to another room */

go(X) :-
        timer_check,
        current_room(Y, _),
        once((passage(Y, X); passage(X, Y))),
        go_(X),
        assert(passage_stack(Y)), !.

go(_) :-
        writeln('I you cannot go there').

go_(X) :-
        retractall(current_room(_, _)),
        floor(X, Z),
        assert(current_room(X, Z)),
        format('Welcome to the ~s\n\n', [X]),
        look, !.

back :-
        passage_stack(_),
        findall(X, passage_stack(X), Stack),
        last(Stack, Back),
        retract(passage_stack(Back)),
        go_(Back), !.

back :-
        writeln('There is no way back').

