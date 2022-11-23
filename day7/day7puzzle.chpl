use IO;
use List;

config const file = "day7input.txt";
config const debug = true; 


    proc processFile (): list (int) {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        
        var numbers: list(int);
        var endOfFile: bool = false; 
        do {
            const num = reader.read(int);
            numbers.append (num); 
            try {
                reader.readf(",");
            } catch {
                endOfFile = true; 
            }

        } while (!endOfFile);
        
        reader.close();
        dataFile.close();

        return numbers;
    }

    proc calcFuelCosts(crabPos: list (int)): [] int {
        var maxPos = max reduce crabPos;
        if debug then 
            writeln ("Highest Position Number ", maxPos);

        var costs : [0..maxPos] int;

        for crab in crabPos do { 
            for pos in 0..maxPos do {
                costs[pos] += abs (crab - pos); 
            }
        }
        if debug {
            for pos in 0..maxPos do {
                writeln ("Position ",pos," Cost: ", costs[pos]);
            }

        } 
        return costs;
    }

    proc main () {
        var crabPos: list (int) = processFile();
        var costs = calcFuelCosts (crabPos); 
        var (minCost, minLoc) = minloc reduce zip(costs, costs.domain);
        writeln ("Lowest cost: ", minCost, " at location: ", minLoc); 
    }
