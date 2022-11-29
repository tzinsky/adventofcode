use IO;

use List;

config const file = "day8input.txt";
config const debug = true; 


    proc processFile () {

        var sigPatterns, outVals: list(string);
        var input, pattern, output: string; 
        
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        while (reader.readLine(input, -1, true)) {
            if debug then 
                writeln ("Signal Pattern Input:  ", input);
            var splitVals = input.split(" | ");
            sigPatterns.append(splitVals[0]);
            outVals.append(splitVals[1]);
        }   

        reader.close();
        dataFile.close();

        countUniqueOuputs(outVals);
    }

    proc countUniqueOuputs (displayVals: list(string)) {
        var uniques: int = 0;

        for dispLine in displayVals {
            var splitDigits = dispLine.split(" ");
            for digit in splitDigits {
                if (digit.size == 2 || digit.size == 3 || digit.size == 4 || digit.size == 7 ) then
                    uniques +=1;
                writeln (digit);
            }
        }
        writeln ("Number of uniques: ", uniques);
    }

    proc main () {
        processFile();
    }
