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
        write('Hmm, what a fancy wardrobe is right in my path'), nl, !.

describe(corridor_1_floor) :-
        write('Oooh, now I can move on'), nl, !.

describe(room3) :- writeln('All the wall a covered with acoustic boards in this room.'), !.

describe(room4) :-
        write('Small room.'), nl,
        write('There was a work table and an armchair in the room, and a picture hung on the wall.'), nl, !.

describe(room5) :-
        writeln('room5 ¯\\_(ツ)_/¯').

describe(fridge) :- writeln('Oooh, it''s time to update this old refrigerator. Buzzing like a plane on the runway'), !.

describe(sofa) :- writeln('What an old shabby sofa. How can you sit on it?'), !.

describe(key) :- writeln('Yes, it''s a key.'), !.

describe(wardrobe) :- writeln('A large oak wardrobe closes the passage to the rooms on the 2nd floor'), !.

describe(carpet) :- writeln('Great modern carpet. The truth does not fit into the interior of the house a little, looks suspicious.'), !.

describe(armchair) :- writeln('A chair is like a chair. lol what else to say'), !.

describe(picture) :- writeln('The picture was kind of weird. This was a screenshot of the top 13 in PUBG solo'), !.

describe(case) :-
        writeln('You found a case! You need to enter a four-digit number. To open this case.'), !.

describe(laptop) :- writeln('Eeeee, I found! - take(laptop)'), !.

describe(pine_door) :- writeln('A pine door with a big glass panel. Shall i try opening it? - open(X)'), !.

describe(oak_door) :- writeln('A Massive internal oak door. Shall i try opening it? - open(X)'), !.

describe(doormat) :- writeln('Good old welcome doormat.'), !.

describe(hole) :- writeln('This hole is as dark as a black hole'), !.

describe(stove) :- writeln('White stove, surprisingly clean. Is rarely used.'), !.

describe(acoustic_guitar) :- writeln('Some strings are missings.'), !.

describe(poster) :- writeln('Metallica poster with a dark falcon on it.'), !.

describe(music_stand) :- writeln('Music stand with some sheets.'), !.

describe(litter_box) :- writeln('Blue litter box with sand. Fortunately with no wastes.'), !.

describe(cat) :- writeln('Black cat with white paws and belly.'), !.

describe(beanbag_chair) :- writeln('Big beanbag chair full covered in cat hair.'), !.

describe(scratching_post) :- writeln('Cat claw scratcher with hanging ball.'), !.

describe(_) :- writeln('It smells like 404 to me. Something went wrong.'), !.