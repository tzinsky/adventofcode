use IO;
use List;
use Set;

config const file = "day8input.txt";
config const debug = true; 


    proc processFile () {

        var sigPatterns, displayVals: list(string);
        var input, pattern, output: string; 
        
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        while (reader.readLine(input, -1, true)) {
            if debug then 
                writeln ("Signal Pattern Input:  ", input);
            var splitVals = input.split(" | ");
            sigPatterns.append(splitVals[0]);
            displayVals.append(splitVals[1]);
        }   

        reader.close();
        dataFile.close();

        countUniqueOuputs(displayVals);
        decodeOutputs(sigPatterns, displayVals);
    }

    proc countUniqueOuputs (displayVals: list(string)) {
        var uniques: int = 0;

        for dispLine in displayVals {
            var splitDigits = dispLine.split();
            for digit in splitDigits {
                if (digit.size == 2 || digit.size == 3 || digit.size == 4 || digit.size == 7 ) then
                    uniques +=1;
                writeln (digit);
            }
        }
        writeln ("Number of uniques: ", uniques);
    }

    proc decodeOutputs (sigPatterns: list(string), displayVals: list(string)) {
        var sum: int = 0;
        var value: int; 
        var items: range  = sigPatterns.indices; 

        for entry in items {
   //         var encodedVals: [0..9] set(string); 
            // use the sig pattern to build the decode
            var encodedVals = buildEncoder(sigPatterns[entry]);
            // Decode string 
            write (displayVals[entry], ": ");
            value = 0;
            for disVar in displayVals[entry].split() {
                var encoded = new set (string, disVar); 
               
                for enc in encodedVals.domain {
                    if (encoded == encodedVals[enc]) {
                        value = value * 10 + enc; 
                    }
                }
            }
            writeln(value);
            sum += value;            
     }
        writeln ("Sum of decoded values: ", sum);
    }

    proc buildEncoder (signal:string): [0..9] set(string) {
        var retEncoder : [0..9] set (string);
        var digits = signal.split();                
        for digit in digits {
            select (digit.size) {
                when 2 {  // 2 segments = 1 
                    retEncoder[1] = new set(string, digit);
                 }
                when 3 {  // 3 segments = 7
                    retEncoder[7] = new set(string, digit);
                }
                when 4 { // 4 segments = 4
                    retEncoder[4] = new set(string, digit);
                }
                when 7 { // 7 segments = 8
                    retEncoder[8] = new set(string, digit);
                }
            }
        }
        var encoded: set (string);
        for digit in digits {
            if (digit.size == 6) { // could be 0, 6 or 9
                encoded = new set (string, digit);
                if ((encoded & retEncoder[1]) != retEncoder[1]) {
                    retEncoder[6] = encoded;
                } else if ((encoded & retEncoder[4]) != retEncoder[4]) {
                    retEncoder[0] = encoded; 
                } else {
                    retEncoder[9] = encoded;
                }
            }
        }
        for digit in digits {
            if (digit.size == 5) { // could be 2,3,5
                encoded = new set (string, digit);
                if ((encoded & retEncoder[1]) == retEncoder[1]) {
                    retEncoder[3] = encoded; 
                } else if ((encoded & retEncoder[9]) == encoded) {
                    retEncoder[5] = encoded; 
                } else {
                    retEncoder[2] = encoded; 
                }
            }
        }
        writeln (retEncoder);
        return retEncoder;

    }

    proc main () {
        processFile();
    }
