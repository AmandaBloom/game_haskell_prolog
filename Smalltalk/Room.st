Object subclass: Room [
   | room description has des |
   Room class >> new [
      | room |
      room := super new.
      room init.
      ^ room
   ]
    
   init [
      room := 'hallwayGroundFloor'.
      
      description := Dictionary new.
      description at: 'hallwayGroundFloor' put: #('I''m in hallwayGroundFloor. What a long corridor. For a long time Mister Zero hasn''t done cleaning here. What huge spiders are sitting on the ceiling').
      description at: 'room1' put: #('You are in the first room. Damn, the door to the next room is closed. I have to find the key to the door to open the door to the second room.').
      description at: 'room2' put: #('It''s so empty here, like after a robbery...').
      description at: 'corridor1Floor' put: #('Hmm, what a fancy wardrobe is right in my path...').
      description at: 'room3' put: #('All the wall a covered with acoustic boards in this room.').
      description at: 'room4' put: #('Small room. There was a work table and an armchair in the room,and a picture hung on the wall.').
      description at: 'room5' put: #('room5, it seems like it''s his office!').
      
      has := Dictionary new.
      has at: 'hallwayGroundFloor' put: #('oldChair' 'carKeys' 'doormat' 'pineDoor' 'oakDoor').
      has at: 'room1' put: #('wallClock' 'sofa' 'fridge' 'stove').
      has at: 'room2' put: #('').
      has at: 'corridor1Floor' put: #('wardrobe').
      has at: 'room3' put: #('carpet' 'musicStand' 'acousticGuitar' 'poster').
      has at: 'room4' put: #('picture' 'workTable' 'armchair').
      has at: 'room5' put: #('litterBox' 'cat' 'beanbagChair' 'scratchingPost').
   ]
     
   list: collection at: location [
      ^ (collection at: location ifAbsent: [#()])
   ]

   lookAround [
      ^ (description at: room), #(''), #('We gotta: '), (self list: has at: room), #('')
   ]

   getCurrentRoom [
      ^ room.
   ]

   changeRoom: new_room[
      room := new_room.
      ^ self look.
   ] 
]