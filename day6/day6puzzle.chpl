use IO;
use List;

config const file = "day6input.txt";
config const debug = true; 
config const skipFishList = true; 
config const days: int = 0;


    proc processFile () : [0..8] int{
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        var numbers: [0..8] int;
        var endOfFile: bool = false; 
        do {
            const num = reader.read(int);
            numbers[num] += 1; 
            try {
                reader.readf(",");
            } catch {
                endOfFile = true; 
            }

        } while (!endOfFile);

        if (debug) then 
            writeln (numbers);

        reader.close();
        dataFile.close();
        return numbers;

    }

    // This version is cute and matches the output on the problem example but it is 
    // computationally inefficient in large numbers.   Stepping each value
    // becomes really really ugly. 
    proc fishSpawner(initialFish: [0..8] int, days: int) : [0..8] int {

        writeln ("Initial state: ", initialFish);
        var fishList: list(int) = initialFish;
        for day in 1..days do {
            coforall f in 0.. fishList.size-1 {
                fishList[f] -= 1;
                if (fishList[f] == -1) {
                    fishList[f] = 6; 
                    fishList.append(8);
                }
            }
            if !skipFishList then 
                writeln("After   ", day, " day: ", fishList);                
            if debug then 
                writeln ("Day ", day, " Count: ", fishList.size); 
        }
        return fishList;
    }

    // Stole some of this from John... But I don't understand his solution really
    // This makes a bit more sense to me - still brute force

    proc newFishSpawner (input: [0..8] int, days: int) : [0..8] int {
        var fishList: [0..8] int = input; 
        for day in 1..days do {
            // All fish of age zero 
            var temp = fishList[0];
            for f in 1..8 {
                // Shift all fish ages down
                fishList[f-1] = fishList[f];
            }
            // We add those fish at age zero to age 6
            fishList[6] += temp;
            // spawn new age eight fish
            fishList[8] = temp;
            if debug then 
                writeln ("Day: ", day, " Fish counts: ", fishList); 
        }
        return fishList;

    }
   
    proc main () {
        var fishList: [0..8] int;
        fishList = processFile();
//        fishList = fishSpawner(fishList, days);
        fishList = newFishSpawner(fishList, days);
        writeln("Total fish: ", + reduce fishList);

    }
