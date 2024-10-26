This is a finite state machine written in vhdl, simulating the functionality of a vending machine, with a single product.

Properties of the simulated vending machine: 
  - accepts a 5 and 10 multiple of a generic curency
  - maximum accumulation of 15 curencies
  - user can make purchases and add more money until change is requested
  - if no purchase is made, user is taxed one curency
  - if curency is addded past the maximum accepted, the last curency addition is refused
  - keep track of current accumulated bills and return all curency accumulated from the last purchase
if there is not enough change for after the current purchase

The machines ususes 3 types of states: 
  1. states used for accumulation before any product is purchased, so the user can be taxed if he directly asks for change
  2. states used for accumulation after a purchase, as to not tex the user
  3. change states indicating how much chnage needs to be given

Transitions from one state to the other is only made on the rising edge of a clock signal.
The reset signal is asynchronous, the current state resets to the intial state no matter the current state of the machine or the clock signal state.
