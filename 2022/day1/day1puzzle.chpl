use IO;
use List;
use Sort; 

config const file = "day1input.txt";
config const debug = true; 
config const elves = 3; 

    proc processFile (){
        var eof:int = 0;
        var calList: list (int); 
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var totalCal, maxCals:int = 0;
        var strCals:string;
        do {
            try {
                eof = reader.readLine(strCals);
                if (eof ==0 || strCals == "\n") {
                    if debug then 
                        writeln(totalCal);
                    calList.append(totalCal);
                    maxCals = max (maxCals, totalCal);
                    totalCal = 0;
                } else {
                    if debug then 
                        writeln ("adding ", strCals:int);
                    totalCal += strCals:int;
                }
            } catch {
                eof=0;
            }
        } while (eof != 0);

        calList.sort(comparator=reverseComparator);

        writeln (calList);
        writeln ("Max Calories: ", maxCals);
        writeln ("Top 3 max cals: ", +reduce [e in 0..<elves] calList[e]);
        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
