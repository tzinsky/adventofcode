use IO;
use List;
use Set;
use Math;

config const file = "day9input.txt";
config const debug = true; 

    proc moveTheRope (moves: list(string)) {
        var tailTouches:set (2*int); 
        var head, tail: 2*int = (0,0);
        var x, y: int = 0;
        for move in moves {
            select (move(0)) {
                when "R" {
                    head[0] +=1;
                }
                when "L"{
                    head[0]-= 1;
                }
                when "U" {
                    head[1] += 1;
                }
                when "D" {
                    head[1] -= 1;
                }
            }
            // Does tail still touch?
            if ((abs(head[0]-tail[0]) >1) || (abs(head[1] - tail[1]))>1) { 
                // N: Move tail
                tail[0] += sgn(head[0]-tail[0]);
                tail[1] += sgn(head[1]-tail[1]);
            }
            tailTouches.add(tail);
        }
        writeln(tailTouches.size);
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

        moveTheRope(ropeMoves);

    }

    proc main () {
        processFile();
    }
