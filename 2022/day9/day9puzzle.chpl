use IO;
use List;
use Set;
use Math;

config const file = "day9input.txt";
config const debug = true; 


    proc moveTheRope (length: int, moves: list(string)) {
        var tailTouches:set (2*int); 
        var rope: [1..length] (2*int);
        tailTouches.add(rope.last); 

        for move in moves {
            // Move the front knot
            select (move(0)) {
                when "R" {
                    rope[1][0] +=1;
                }
                when "L"{
                    rope[1][0]-= 1;
                }
                when "U" {
                    rope[1][1] += 1;
                }
                when "D" {
                    rope[1][1] -= 1;
                }
            }
            // Move the follow up knots
            for i in 1..length-1 {
                if ((abs(rope[i][0]-rope[i+1][0])>1) || (abs(rope[i][1] - rope[i+1][1])>1)) {
                    rope[i+1][0] += sgn(rope[i][0]-rope[i+1][0]);
                    rope[i+1][1] += sgn(rope[i][1]-rope[i+1][1]);
                }
            }
//            // Does tail still touch?
//            if ((abs(rope.first[0]-rope.last[0]) >1) || (abs(rope.first[1] - rope.last[1]))>1) { 
//                // N: Move tail
//                rope[2][0] += sgn(rope.first[0]-rope.last[0]);
//                rope[2][1] += sgn(rope.first[1]-rope.last[1]);
//                writeln (rope.last);
//            }
            // Add tail to set
            tailTouches.add(rope.last);
        }
        writeln("Tail moves for a rope of length: ", length, " is: ", tailTouches.size);
    }

    proc processFile (){
        var ropeMoves:list (string);
        var dataFile = open(file, ioMode.r);
        var reader = dataFile.reader();
        var direction: string;
        var count: int; 
        while (reader.readf("%s %i",direction, count )) do {
            for i in 1..count {
                ropeMoves.pushBack(direction);
            }
        }
        reader.close();
        dataFile.close();

        moveTheRope(2, ropeMoves);

        moveTheRope(10, ropeMoves);
    }

    proc main () {
        processFile();
    }
