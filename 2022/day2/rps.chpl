// Here we are going to test some ideas around writing code for the 
// rock -> scissors -> paper -> rock that is part of the AOC day 2 
// problem.  
// 
// In the problem, a win is worth 6 points, tie is worth 3 and loss is 0.
// 
// Now the actual selections have weight too: 
//      rock = 1, paper = 2, scissors =3 
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
use IO; 

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
//for item in readGuide() {
//    writeln (item:int);
//}

// The problem is that if the options grow and we support the rock paper scissors lizard spock
// game: https://bigbangtheory.fandom.com/wiki/Rock,_Paper,_Scissors,_Lizard,_Spock.   Again 
// hardcoding can be done but we want the computer to do that.  
// 
