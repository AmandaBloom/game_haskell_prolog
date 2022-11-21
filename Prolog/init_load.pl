init_load :-
        retractall(title(_, _)), retractall(current_room(_, _)), retractall(alive(_)), retractall(passage(_, _)),
        retractall(at(_, _)),  retractall(in(_, _)), retractall(behind(_, _)), retractall(floor(_, _)),
        retractall(locked(_)), retractall(picture(_)),

        assert(alive(player)),
        assert(locked(fridge)),
        assert(locked(case)),
        assert(picture(onwall)),

        % at(thing, someplace),
        /* hallway_ground_floor */
        assert(at(old_chair, hallway_ground_floor)),
        assert(at(car_keys, hallway_ground_floor)),
        assert(at(doormat, hallway_ground_floor)),
        assert(at(pine_door, hallway_ground_floor)),
        assert(at(oak_door, hallway_ground_floor)),
        assert(at(fiberboard_door, hallway_ground_floor)),

        /* room1 */

        assert(at(wall_clock, room1)),
        assert(at(sofa, room1)),
        assert(at(fridge, room1)),
        assert(at(stove, room1)),


        /* corridor_1_floor */

        assert(at(wardrobe, corridor_1_floor)),

        /* room3 */

        assert(at(carpet, room3)),
        assert(at(music_stand, room3)),
        assert(at(acoustic_guitar, room3)),
        assert(at(poster, room3)),

        /* room4 */

        assert(at(picture, room4)),
        assert(at(work_table, room4)),
        assert(at(armchair, room4)),

        /* room5 */

        assert(at(litter_box, room5)),
        assert(at(cat, room5)),
        assert(at(beanbag_chair, room5)),
        assert(at(scratching_post, room5)),

        assert(title(cat, 'cat (sleeping)')),


        /* Describe floor where room is located */

        assert(floor(outside, ground_floor)),
        assert(floor(hallway_ground_floor, ground_floor)),
        assert(floor(room1, ground_floor)),
        assert(floor(room2, ground_floor)),

        assert(floor(corridor_1_floor, first_floor)),
        assert(floor(room3, first_floor)),
        assert(floor(room4, first_floor)),
        assert(floor(room5, first_floor)),
        assert(floor(hole, first_floor)),

        /* Describe paths to rooms */

        assert(passage(hallway_ground_floor, outside)),
        assert(passage(hallway_ground_floor, room1)),
        assert(passage(corridor_1_floor, room3)),
        assert(passage(corridor_1_floor, room4)),

        assert(current_room(hallway_ground_floor, ground_floor)),

        !.
