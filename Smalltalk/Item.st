Object subclass: Item [
    | description des actions act isAt hasHidden isTakeable isLocked isMoved openWith|
    Item class >> new [
        | item |
        item := super new.
        item init.
        ^ item
    ]
    
    init [

     description := Dictionary new.
     description at: 'carKeys' put: 'Nice ... Besides being a villain, he also has a taste for cars. It''s like a code written at the belt - 1337. It may help me sometime. Car Alarm System pilot has 2 unlabeled buttons.'.
     description at: 'oldChair' put: 'Looks like he likes old things, but he doesn''t take care  of them. Very well...'.
     description at: 'oakDoor' put: 'A Massive internal oakDoor.'.
     description at: 'doormat' put: 'Good old welcome doormat.'.
     description at: 'pineDoor' put: 'A pineDoor with a big glass panel.'.
     description at: 'fridge' put: 'Oooh, it''s time to update this old refrigerator. It''s Buzzing like a plane on the runway.'.
     description at: 'sofa' put: 'What an old shabby sofa. How can you sit on it?'.
     description at: 'wallClock' put: 'It ain''t working from 1:37. Maybe its a sign???'.
     description at: 'stove' put: 'White stove, surprisingly clean. Is rarely used.'.
     description at: 'wardrobe' put: 'A large oak wardrobe closes the passage to the rooms on the 2nd floor.'.
     description at: 'carpet' put: 'Great modern carpet. The truth does not fit into the interior  of the house a little'.
     description at: 'acousticGuitar' put: 'Some strings are missings.'.
     description at: 'poster' put: 'Metallica poster with a dark falcon on it.'.
     description at: 'musicStand' put: 'Music stand with some sheets.'.
     description at: 'armchair' put: 'Standard armchair, nothing interesting here.'.
     description at: 'workTable' put: 'It''s clear, mkay..'.
     description at: 'picture' put: 'Is it a picture of a woman. I wonder who it is, on the back  there''s signed "Jules 1978".'.
     description at: 'safe' put: 'You found a safe ! You need to enter a four-digit number.  To open this safe.'.
     description at: 'code' put: '1337'.
     description at: 'laptop' put: 'Eeeee, I found!'.
     description at: 'litterBox' put: 'Blue litter box with sand. Fortunately with no wastes.'.
     description at: 'cat' put: 'Black cat with white paws and belly. It''s still sleeping... even when I opened door.'.
     description at: 'beanbagChair' put: 'Big beanbag chair full covered in cat hair.'.
     description at: 'scratchingPost' put: 'Cat claw scratcher with hanging ball.'.
     description at: 'zincKey' put: 'Zinc key - It could be usefull.'.


     actions := Dictionary new.
     actions at: 'carKeys' put: 'I will remember this code - take code I will take carKeys'.
     actions at: 'oakDoor' put: 'Shall i try opening it? - open'.
     actions at: 'pineDoor' put: 'Shall i try opening it? - open'.
     actions at: 'fridge' put: ''.
     actions at: 'wardrobe' put: '- move'.
     actions at: 'picture' put: '- move'.
     actions at: 'safe' put: 'Shall i try opening it? - open'.
     actions at: 'laptop' put: '- take'.

    
     isAt := Dictionary new.
     isAt at: 'carKeys' put: 'hallwayGroundFloor'.
     isAt at: 'oldChair' put: 'hallwayGroundFloor'.
     isAt at: 'oakDoor' put: 'hallwayGroundFloor'.
     isAt at: 'doormat' put: 'hallwayGroundFloor'.
     isAt at: 'pineDoor' put: 'hallwayGroundFloor'.
     isAt at: 'fridge' put: 'room1'.
     isAt at: 'sofa' put: 'room1'.
     isAt at: 'wallClock' put: 'room1'.
     isAt at: 'stove' put: 'room1'.
     isAt at: 'wardrobe' put: 'corridor1Floor'.
     isAt at: 'carpet' put: 'room3'.
     isAt at: 'acousticGuitar' put: 'room3'.
     isAt at: 'poster' put: 'room3'.
     isAt at: 'musicStand' put: 'room3'.
     isAt at: 'armchair' put: 'room4'.
     isAt at: 'workTable' put: 'room4'.
     isAt at: 'picture' put: 'room4'.
     isAt at: 'safe' put: 'room4'.
     isAt at: 'code' put: ''.
     isAt at: 'laptop' put: 'room4'.
     isAt at: 'litterBox' put: 'room5'.
     isAt at: 'cat' put: 'room5'.
     isAt at: 'beanbagChair' put: 'room5'.
     isAt at: 'scratchingPost' put: 'room5'.
     isAt at: 'zincKey' put: 'room5'.   


     hasHidden := Dictionary new.
     hasHidden at: 'safe' put: #('laptop').


     isTakeable := Dictionary new.
     isTakeable at: 'carKeys' put: true.
     isTakeable at: 'oldChair' put: true.
     isTakeable at: 'oakDoor' put: false.
     isTakeable at: 'doormat' put: false.
     isTakeable at: 'pineDoor' put: false.
     isTakeable at: 'fridge' put: false.
     isTakeable at: 'sofa' put: false.
     isTakeable at: 'wallClock' put: true.
     isTakeable at: 'stove' put: true.
     isTakeable at: 'wardrobe' put: false.
     isTakeable at: 'carpet' put: false.
     isTakeable at: 'acousticGuitar' put: true.
     isTakeable at: 'poster' put: true.
     isTakeable at: 'musicStand' put: true.
     isTakeable at: 'armchair' put: true.
     isTakeable at: 'workTable' put: false.
     isTakeable at: 'picture' put: true.
     isTakeable at: 'safe' put: false.
     isTakeable at: 'code' put: true.
     isTakeable at: 'laptop' put: true.
     isTakeable at: 'litterBox' put: true.
     isTakeable at: 'cat' put: false.
     isTakeable at: 'beanbagChair' put: false.
     isTakeable at: 'scratchingPost' put: false.
     isTakeable at: 'zincKey' put: true.


     isLocked := Dictionary new.
     isLocked at: 'oldChair' put: false.
     isLocked at: 'oakDoor' put: true.
     isLocked at: 'doormat' put: false.
     isLocked at: 'pineDoor' put: true.
     isLocked at: 'fridge' put: true.
     isLocked at: 'wardrobe' put: true.
     isLocked at: 'safe' put: true.
     
     
     isMoved := Dictionary new.
     isMoved at: 'carKeys' put: true.
     isMoved at: 'oldChair' put: true.
     isMoved at: 'oakDoor' put: false.
     isMoved at: 'doormat' put: false.
     isMoved at: 'pineDoor' put: false.
     isMoved at: 'fridge' put: false.
     isMoved at: 'sofa' put: false.
     isMoved at: 'wallClock' put: false.
     isMoved at: 'stove' put: false.
     isMoved at: 'wardrobe' put: true.
     isMoved at: 'carpet' put: false.
     isMoved at: 'acousticGuitar' put: true.
     isMoved at: 'poster' put: true.
     isMoved at: 'musicStand' put: true.
     isMoved at: 'armchair' put: true.
     isMoved at: 'workTable' put: false.
     isMoved at: 'picture' put: true.
     isMoved at: 'laptop' put: false.
     isMoved at: 'litterBox' put: true.
     isMoved at: 'cat' put: false.
     isMoved at: 'beanbagChair' put: false.
     isMoved at: 'scratchingPost' put: true.
     isMoved at: 'zincKey' put: true.

     openWith := Dictionary new.
     openWith at: 'safe' put: 'code'.
     openWith at: 'oakDoor' put: 'zincKey'.

     ]
     
    info: object [ 
        des := (description at: (object) ifAbsent: [#()]).
        act := (actions at: (object) ifAbsent: [#()]).
        ^ { des, ' ', act }.
    ]

    hiddenObjInfo: object [
        ^ #('There are following objects in it: '), (hasHidden at: (object) ifAbsent: [#()]), #('')
    ]

    getHidden: object [
        ^ hasHidden at: object ifAbsent: [nil.].
    ]

    ifIsLocked: object [
        ^(isLocked at: (object) ifAbsent: [true.])
    ]
]