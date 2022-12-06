use IO;
use List;

config const file = "day5input.txt";
config const debug = true; 

    proc dumpResults (crates: [] list(string)) {
        writeln (crates);
        write ("Top of each stack spells: ");
        for p in 1..crates.size {
            write (crates[p].first());
        } 
        writeln();
    }

    proc cargo9000Crane (startCrates: [] list(string), instructions:list([0..2] int)) {

        var crates: [1..startCrates.size] list(string) = startCrates; 
        for inst in instructions {
            if debug then 
                writeln ("Moving ", inst[0], " crates from ", inst[1], " to ", inst[2]);
            for m in 0..<inst[0] {
                crates[inst[2]].insert(0,crates[inst[1]].pop(0));
                if debug then
                  writeln (crates);            
            }
        }
        dumpResults(crates);
    }

    proc cargo9001Crane (startCrates:[] list (string), instructions:list([0..2] int)) {
        var crates: [1..startCrates.size] list(string) = startCrates; 
        for inst in instructions {
            if debug then 
                writeln ("Moving ", inst[0], " crates from ", inst[1], " to ", inst[2]);
            var c2m: list(string) = new list(string);
            for m in 0..<inst[0] {
                c2m.append(crates[inst[1]].pop(0));
            }
            crates[inst[2]].insert(0,c2m);
            if debug then
                writeln (crates);            
        }
        dumpResults(crates);
    }

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

        var instructions: list([0..2] int);
        var mvCount, fromStack, toStack: int;
        while (reader.readf("move %i from %i to %i\n", mvCount, fromStack, toStack)) {
            instructions.append([mvCount, fromStack, toStack]);
        }

        cargo9000Crane(arrayOfLists, instructions);
        cargo9001Crane(arrayOfLists, instructions);
      
        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
