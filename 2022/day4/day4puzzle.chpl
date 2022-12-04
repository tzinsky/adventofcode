use IO;
use List;

config const file = "day4input.txt";
config const debug = true; 


    proc processFile (){
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var low1, low2, high1, high2:int;
        var intersection, overlap:int = 0;
        while (reader.readf("%i-%i,%i-%i",low1,high1,low2,high2)){
            if debug then
                writeln ("Range 1: ", low1, "..", high1, " Range 2: ", low2, "..", high2);

            var range1 = low1..high1;
            var range2 = low2..high2;

            if ((range1.contains(range2)) || range2.contains(range1)) then
                intersection +=1;

            var inRange: bool = false;

            for r in range1 {
                if range2.contains(r) {
                    inRange = true;
                    break;
                }
            }
            if (inRange) then 
                overlap += 1; 
        }

        writeln("Number of intersections: ", intersection);
        writeln("Number of overlapping ranges: ", overlap);
        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
