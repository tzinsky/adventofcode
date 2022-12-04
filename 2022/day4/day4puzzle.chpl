use IO;
use List;

config const file = "day4input.txt";
config const debug = true; 


    proc processFile (){
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var low1, low2, high1, high2:int;
        var dash, comma: string;
        var intersection:int = 0;
        while (reader.readf("%i%c%i%c%i%c%i",low1,dash,high1,comma,low2,dash,high2)){
            if debug then
                writeln ("Range 1: ", low1, "..", high1, " Range 2: ", low2, "..", high2);

            var range1 = low1..high1;
            var range2 = low2..high2;

            if ((range1.contains(range2)) || range2.contains(range1)) then
                intersection +=1;

        }

        writeln("Number of intersections: ", intersection);
        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
