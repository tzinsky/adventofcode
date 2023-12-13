use IO;
use List;
use Sort;

config const file = "day1input.txt";
config const debug = true; 

    var numConvert = [["zero", "0"],
                      ["one", "1"], 
                      ["two", "2"], 
                      ["three", "3"],
                      ["four", "4"],
                      ["five", "5"],
                      ["six", "6"],
                      ["seven", "7"],
                      ["eight", "8"], 
                      ["nine", "9"]];

    proc convertWords2Nums(str:string): string {
        var retStr: string = str;
        for  numReplace in numConvert do {
            retStr = retStr.replace(numReplace[0], numReplace[1], -1);
        }
        writeln ("Input: ", str, " Output: ", retStr);
        return retStr; 
    }

    proc checkString (str: string): int {
        var retVal: int = -1; 
        for i in 0..<numConvert.size {
            if (str.startsWith(numConvert[i](0),numConvert[i](1))){
                retVal = i;
                break; 
            }
        }
        return retVal;
    }

    proc findDigit (str:string, direction:int): int {
        var retVal: int = 0;
        var checkedVal: int; 
        for i in (str.indices by direction) {
            checkedVal = checkString(str.this(i..<str.size)); 
            if (checkedVal != -1 ) {
                retVal= checkedVal;
                break; 
            }
        }
        return retVal; 
    }

    proc processFile (){
        var sum: int = 0; 
        var num: int = 0;
        var calDocEntry:string;
        var convertedCalDocEntry: string; 
        var dataFile = open(file, ioMode.r);
        var reader = dataFile.reader();
        while (reader.readLine(calDocEntry, -1, true)) do {
//            writeln (calDocEntry, " ", findDigit(calDocEntry, 1), " ", findDigit(calDocEntry, -1));
            num = findDigit(calDocEntry, 1) * 10 + findDigit(calDocEntry, -1);
            if debug then 
                writeln (calDocEntry, " ", convertedCalDocEntry, " ", num); 
            sum += num; 
        }
        reader.close();
        dataFile.close();

        writeln ("Calibration values equal: ", sum);

    }

    proc main () {
        processFile();
    }
