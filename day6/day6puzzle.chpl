use IO;
use List;

config const file = "day6input.txt";
config const debug = true; 
config const days = 80;


    proc processFile () : list (int){
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

        if (debug) then 
            writeln (numbers);

        reader.close();
        dataFile.close();
        return numbers;

    }

    proc fishSpawner(initialFish: list(int), days: int) : list(int) {

        writeln ("Initial state: ", initialFish);
        var fishList: list(int) = initialFish;
        for day in 1..days do {
            for f in 0.. fishList.size-1 {
                fishList[f] -= 1;
                if (fishList[f] == -1) {
                    fishList[f] = 6; 
                    fishList.append(8);
                }
            }
            writeln("After   ", day, " day: ", fishList);                
        }
        return fishList;
    }

   
    proc main () {
        var fishList: list (int);
        fishList = processFile();
        fishList = fishSpawner(fishList, days);
        writeln("Total fish: ", fishList.size);

    }
