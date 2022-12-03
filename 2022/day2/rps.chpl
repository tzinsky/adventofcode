// Here we are going to test some ideas around writing code for the 
// rock -> scissors -> paper -> rock that is part of the AOC day 2 
// problem.  
// 
// In the problem, a win is worth 6 points, tie is worth 3 and loss is 0.
// 
// Now the actual selections have weight too: 
//      A, X = rock = 1, B, y = paper = 2, C, Z =scissors =3 
//
//  One thought is we could just hardcode it: 
//
// AX = 3+1 = 4
// AY = 6+2 = 8
// AZ = 0+3 = 3
// BX = 0+1 = 1
// BY = 3+2 = 5
// BZ = 6+3 = 9
// CX = 6+1 = 7
// CY = 0+2 = 2
// CZ = 3+3 = 6 
//
//  That is not a terribly long list and would make solving the problem super easy.
//  Create those as a giant enum, read the data using that enum - do the calculation and win.
//  I mean it's a bit more than that.   
/*use IO; 

enum rpsGame {AX=4, AY=8, AZ=3, BX=1, BY=5, BZ=9, CX=7, CY=2, CZ=6};
use rpsGame;

var elf1, elf2: string; 

iter readGuide () {
    var combined: string;
    while (readf("%s %s", elf1, elf2)) do {
        combined = elf1+elf2;
        yield (combined:rpsGame);
    }
}

var guideTotal = + reduce readGuide():int;
writeln (guideTotal);
*/
//for item in readGuide() {
//    writeln (item:int);
//}

// The problem is that if the options grow and we support the rock paper scissors lizard spock
// game: https://bigbangtheory.fandom.com/wiki/Rock,_Paper,_Scissors,_Lizard,_Spock.   Again 
// hardcoding can be done but we want the computer to do that.  
// 
// Part 2 is modifies this approach a little.  The entries now have different weights: 
//      A = rock = 1, B = paper = 2, C =scissors =3 
// And the second part reflects win loss or tie where the values fit like this: 
//      X = lose = 0, Y = tie = 3 , Z = win = 6
// 
// AX = 3+0 = 3
// AY = 1+3 = 4
// AZ = 2+6 = 8
// BX = 1+0 = 1
// BY = 2+3 = 5
// BZ = 3+6 = 9
// CX = 2+0 = 2
// CY = 3+3 = 6
// CZ = 1+6 = 7
//  
// To run this mess- simply pipe (<) the input data to the program.   
use IO; 

enum rpsGame {AX=4, AY=8, AZ=3, BX=1, BY=5, BZ=9, CX=7, CY=2, CZ=6};
enum rpsStrat {AX=3, AY=4, AZ=8, BX=1, BY=5, BZ=9, CX=2, CY=6, CZ=7};
use rpsGame;

var elf1, elf2: string; 

iter readGuide () {
    var combined: string;
    while (readf("%s %s", elf1, elf2)) do {
        combined = elf1+elf2;
        yield (combined:rpsGame, combined:rpsStrat);
    }
}

var totals = readGuide();
var matchTotal = + reduce [c in 0..<totals.size] totals[c](0):int;
writeln (matchTotal);
var guideTotal = + reduce [c in 0..<totals.size] totals[c](1):int;
writeln (guideTotal);
