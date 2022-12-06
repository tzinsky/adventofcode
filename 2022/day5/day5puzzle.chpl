use IO;
use List;

config const file = "day5input.txt";
config const debug = true; 


    proc processFile (){
        var stacks: list(string);
        var crates:string; 
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var endOfFile = false; 

        do {
            reader.readLine(crates, -1, true);
            if (crates.size != 0) {
                stacks.append(crates);
                if debug then
                    writeln (crates, " String size: ", crates.size);
            } else { 
                endOfFile = true; 
            }
        } while (!endOfFile);

        var stackCount: int =stacks.last()[stacks.last().size-2]:int;  
        writeln ("Number of stacks: ", stackCount); 
        stacks.pop(); 
        // Convert to an array of lists
        var arrayOfLists: [1..stackCount] list(string);
        for s in stacks {
            var stepper = 1;
            for i in 1..<s.size by 4 {
                if (s[i] != " ") then 
                    arrayOfLists[stepper].append(s[i]);
                stepper +=1;
            }
        }
        if debug then
            writeln (arrayOfLists);

        var mvCount, fromStack, toStack: int;
        while (reader.readf("move %i from %i to %i\n", mvCount, fromStack, toStack)) {
            writeln ("Moving ", mvCount, " crates from ", fromStack, " to ", toStack);
            for m in 0..<mvCount {
                arrayOfLists[toStack].insert(0,arrayOfLists[fromStack].pop(0));
                if debug then
                  writeln (arrayOfLists);            
            }
        }
        writeln (arrayOfLists);
        write ("Top of each stack spells: ");
        for p in 1..stackCount {
            write (arrayOfLists[p].first());
        } 
        writeln();
        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
