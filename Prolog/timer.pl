:- dynamic timer/1. % time in milliseconds
:- retractall(timer(_)).

/* This rule describes how to start a timer (time in milliseconds) */

start_timer(Period_ms) :-
        statistics(walltime, [Time_since_program_start, _]),
        retractall(timer(_)),
        T is Time_since_program_start + Period_ms,
        assert(timer(T)).

/* This rule describes how to check how much time is left */

timer_time_left(R) :-
        statistics(walltime, [Time_since_program_start, _]),
        timer(End_time),
        R is End_time - Time_since_program_start.

/* This rule describes how to write out how to check how much time is left */

time_left :-
        timer_time_left(R),
        divmod(R, 60000, Min, Remainder),
        divmod(Remainder, 1000, Sec, _),
        format('You can see ~|~`0t~d~2+:~|~`0t~d~2+ on timer dispay.', [Min, Sec]).

/* This rule defines short cut for time_left */

tl :-
        time_left.

/* This rule describes how to reduce timer time by Period_ms */

reduce_timer_by(Period_ms) :-
        timer(Prev_period),
        New_period is Prev_period - Period_ms,
        retractall(timer(_)),
        assert(timer(New_period)).

/* This rule describes how to reduce timer time to Period_ms.
Time will not be reduced if timer_time_left < Period_ms */

reduce_timer_to(Period_ms) :-
        timer_time_left(R),
        (
        R > Period_ms ->
                start_timer(Period_ms)
        ;
                start_timer(R)
        ).


/* This rule describes how to check if the timer has ended up */

has_expired :-
        timer_time_left(R),
        R < 0.

/* This rule ends up a game if time is out.
It is inteded to be checked every time any action is perform. */

timer_check :-
        has_expired,
        write("Time is out"),
        finish,
        abort.

timer_check.
