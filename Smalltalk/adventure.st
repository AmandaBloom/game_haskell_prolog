Object subclass: Game [
    | isGameOver currentRoom items imAt inventory holding |

    introductionText := #(
        'Welcome Agent!. The world is a dangerous place. Mister Zero wants to make it'
        'even worse. Our intelligence has proven he has nuclear codes and he''s gonna'
        'use them to destroy The World. That''s why you were sent to his house. Search'
        'for the Laptop with codes and protect our future...'
        'Be quick, he is gonna come back in any time... '
        ''
        '...............Agent Of Fortune Game...............'
        ''
        'Finally... You entered Mister Zero''s crib. Front door appears to be intact.'
        'You''re into the hallwayGroundFloor. On the small table there''s note - it says'
        'he will be back soon, so you have 10 minutes to leave the house, hurry up'
        'Start with looking around you:'
        ''
    ).

    instructionsText := #(
        'Available commands are:'
        ''
        'instructions      -- to see these instructions.'
        'turn off          -- To turn of smth in room.'
        'go                -- Enter the room.'
        'back / b          -- Enter the previous room.'
        'take / t          -- Pick up an object.'
        'drop / d          -- Put down an object.'
        'inventory / i     -- Check inventory.'
        'look / l          -- Look around you again.'
        'inspect           -- Look at smth in room.'
        'open / o          -- Open at smth in room,'
        'move / m          -- Move at smth in room.'
        'press / p         -- Press the button.'
        'quit / q          -- to end the game and quit.'
        ''
    ).
 
    Game class >> new [
        | g |
        g := super new.
        g init.
        ^g
    ]

    init [
        isGameOver := false.
        FileStream fileIn: 'Room.st'.
        FileStream fileIn: 'Item.st'.
        currentRoom := Room new.
        items := Item new.
        holding := nil.
        imAt := 'hallwayGroundFloor'.
        inventory  := OrderedCollection new.
    ]

    currentLocation [
        ^ {'You are currently at ', imAt}.
    ]

    "Print strings from array in separate lines."
    printLines: anArray [
        anArray do: [ :string | Transcript show: string; cr ]
    ]

    printIntroduction [
       self printLines: introductionText.
    ]

    printInstructions [
        self printLines: instructionsText.
    ]

    readCommand [
        Transcript show: '> '.
        ^ FileStream stdin nextLine
    ]

    print: array [
        array do: [ :string | Transcript show: string; cr ]
    ]

    joinArgs: args [
        |object|
        args size = 1 ifTrue:[
            object := args.
        ]
        ifFalse: [
            args size = 2 ifTrue:[
                object := args first, ' ', args last.
            ]
            ifFalse: [
                object := args first, ' ', args second, ' ', args last.
            ].
        ].
        ^object.
    ]

    showInventory [
        Transcript show: 'You have following objects in your inventory: '; cr.
        1 to: inventory size do: [
            :x | Transcript show: (inventory at: x) printString; cr.
        ]
    ]
     
    inspect: args [
        |object match|
        (args size > 2) ifTrue: [
            args removeFirst.
            object := self joinArgs: args.
        ]
        ifFalse: [
            object := args last.
        ].
        match := (items ifIsLocked: object).
        match ifTrue:[
            (self print: (items info: (object))).
        ]
        ifFalse: [
            (items getHidden: object) = nil ifTrue:[
                (self print: (items info: (object))).
            ]
            ifFalse: [
                (self print: (items info: (object))).
                (self print: (items hiddenObjInfo: (object))).
            ]
        ].
    ]


    parseCmd: args [
        |arg match object|

        args first = 'take' ifTrue: [
                    self takeObj: args.
                    ^nil.
                ].
        
        args first = 'inspect' ifTrue: [
                    self inspect: args.                        
                    ^nil.
                ].
               
        (args first = 'turn' & args second = 'off' & args last = 'fridge') 
            ifTrue: [
                self printLines: {'Booooom!!! ','You''re dead '}.
                isGameOver := true.
                ^nil.
            ].
        
        match ifFalse: [self printLines: {'You cant do that!'}.]
    ]

    "Run the game."
    run [
        |args|

        self printIntroduction.
        self printInstructions.

        "Game loop."
        [isGameOver] whileFalse: [
            args := (self readCommand) substrings.
            args size = 1 ifTrue: [
                |cmd|
                cmd := args first.
                cmd = 'instructions' ifTrue: [
                    self printInstructions.
                ].

                ((cmd = 'look') | (cmd = 'l')) ifTrue: [
                    self printLines: currentRoom lookAround.
                ].


                ((cmd = 'inventory') | (cmd = 'i')) ifTrue: [
                    self showInventory.
                ].

                ((cmd = 'quit') | (cmd = 'q')) ifTrue: [
                    isGameOver := true.
                ].
            ]
            ifFalse: [
                self parseCmd: args.
            ]
        ]
    ]
]

Game new run.
