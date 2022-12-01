module day1AoC {
    use IO;
    use List;

    config const file = "day1input.txt";


    proc loadData (fileName:string): list(int) {
        var retList: list (int); 

        try {
            var dataFile = open(fileName, iomode.r);
            var reader = dataFile.reader();
            var fileData: int;
            var count: int = 0; 

            while (reader.read(fileData)) {
                count += 1; 
                retList.append(fileData);
            }
            reader.close();
            dataFile.close();
            writeln ("Read ", count, " from ", fileName);

        } catch {
            writeln ("Error encountered and caught...");
        }
        return retList;
    }

    proc sonarSweep (depthList:list(int)) {
        var count: int = 0;
        var prevReading: int = -1;
        var currentReading: int; 

        for currentReading in depthList {
            if (prevReading == -1) then
                writeln (currentReading, " N/A no previous reading");
            else {
                if (currentReading > prevReading) {
                    writeln (currentReading, " Increasing");
                    count += 1;
                }
                else if (prevReading > currentReading) {
                    writeln (currentReading,  " Decreasing");
                }
                else {
                    writeln (currentReading, " No Change");
                }
            } 
            prevReading = currentReading;
        }
        writeln ("Number increasing entries: ", count);
    }


    proc sonarWindow (depthList:list(int), sonarWindowSize: int) {
        var i: int;
        var aggregatedSonarData: list(int);
        var sonarWindow: list(int);

        for i in 0 .. (depthList.size)-sonarWindowSize  {
            sonarWindow.init(depthList[i..i+sonarWindowSize-1]);
            aggregatedSonarData.append (sumListEntries(sonarWindow));
        }
        sonarSweep(aggregatedSonarData);
    }

    proc sumListEntries(window:list(int)): int {
        var sum: int = 0;
        var listVal: int;

        for listVal in window do {
            sum +=listVal;
        }
        return sum;
    }

    proc main ()
    {
        var depthData: list (int);

        depthData = loadData(file);
        sonarSweep(depthData);
        sonarWindow(depthData, 3);

        
    }
}