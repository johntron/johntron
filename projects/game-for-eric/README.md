## TODO:

* Game FSM
* Operations for each move (e.g. lookup?)
* Data structures for board and pieces

## Do later

* Data logging
* Rule checker
* Solver


## Events

* Game begin
* Round begin
* Pick up piece
* * Ensure owned by player for current turn
* Drop piece
* * Calculate captures
* Round end
* Game end

Rule checker:
* How/when to calculate valid positions?
* How to determine victory?
* What to enforce?

Data logging:
* What to record
* How to persist

## State

Game:
* Data structure: FSM
* Round
* Player
* Selected piece

Players:
* Data structure: Array of objects
* Name
* Pieces

Board:
* Data structure: ?
* Dimensions
* Size per dimension

Pieces:
* Data structure: ?
* Coordinates
* Other attributes
