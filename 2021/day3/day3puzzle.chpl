use IO;
use BitOps;
use List;

config const file = "day3input.txt";

    proc convertValue (value: string): int {
        var retValue: int = 0;
        var bitIndex: int = 0;

        for bitIndex in 0..<value.size {
            retValue = value.item(bitIndex):int | retValue;
            if (bitIndex < (value.size-1)) then
                retValue = retValue<<1;
        }         

//        writeln ("Input value: ", value, " Converted to: ", retValue);
        return retValue; 

    }

    proc calculateMostCommonBits (values: list(string), bitPos: int) : 2*int {

        var bitString: string;
        var zero: int = 0;
        var one: int = 0;

        for bitString in values {
            if ((bitString.item(bitPos):int) & 1) then
                    one +=1;
            else
                    zero +=1;
        }
        return (zero,one);
    }

    proc mostCommonBitValue (values: list(string), bitPos: int) : int {
        var retVal: int;
        var bitCounts = calculateMostCommonBits( values, bitPos); 
        
        if (bitCounts(0)>bitCounts(1)) then 
            retVal = 0; 
        else if (bitCounts(0) < bitCounts(1)) then 
            retVal = 1;
        else 
            retVal = 2; 

        return retVal;

    }

    proc displayGammaAndEpsilon (readings: list(string), numBits: int)
    {
        var gamma: int;
        var epsilon: int; 

        for bitIndex in 0..<numBits {
            if (mostCommonBitValue(readings, bitIndex) == 1) then
                epsilon = epsilon | 1; 
            else 
                gamma = gamma | 1;    

            if (bitIndex < (numBits-1)) {
                epsilon = epsilon <<1;
                gamma = gamma<<1; 
            }
                        
        } 

        writeln ("Epislon: ", epsilon," Gamma: ", gamma);
        writeln ("Power Consumption: ", epsilon * gamma);

    }

    proc scrubList (inputList: list(string), bitIndex: int, bitValue: int): list(string) 
    {
        var retList: list(string); 

        for value in inputList {
            if (value.item(bitIndex):int  == bitValue) {
                retList.append(value); 
            }
        }
        return retList; 
    }

    proc pareDownList(listOfBitStrings: list(string), numBits:int, mcb: int): string {

        var bitCounts: 2*int;
        var tempList: list(string) = listOfBitStrings;
        var scrubBit:int; 
        
//        writeln("Starting list: ", tempList);

        for bitIndex in 0..<numBits {
            bitCounts = calculateMostCommonBits (tempList, bitIndex); 
            scrubBit = mcb; 
            if (scrubBit) {
                if (bitCounts(0)> bitCounts(1)) then 
                    scrubBit = 0;
                else
                    scrubBit = 1; 
            }
            else {
                if (bitCounts(0) > bitCounts(1)) then 
                    scrubBit = 1; 
                else 
                    scrubBit = 0;
            }

            tempList = scrubList (tempList, bitIndex, scrubBit);
//            writeln ("BitPosition: ", bitIndex, " Most Common Bit: ", scrubBit, " O2 Generator List ", tempList);
            if (tempList.size == 1) then 
                break;
        }
        return tempList.first();


    }

    proc displayO2andCO2Ratings (readings: list(string), numBits: int)
    {
        var o2GeneratorList: list (string) = readings;
        var cO2ScrubberList: list (string) = readings; 
        var o2GeneratorRating: int = convertValue(pareDownList(readings, numBits, 1));
        var cO2ScrubberRating: int = convertValue(pareDownList(readings, numBits, 0));

        writeln ("O2 Generator Rating: ", o2GeneratorRating);
        writeln ("CO2 Scrubber Rating: ", cO2ScrubberRating);
        writeln ("Life Support Rating: ", o2GeneratorRating * cO2ScrubberRating);

    }

    proc processFile () {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        var diagnostic: string;
        var rawReadings: list(string);
        var convertedValues: list(int);
        var convertedBinary: int; 
        var numBits: int; 

        while (reader.read(diagnostic)) {
            rawReadings.append(diagnostic);
            numBits = diagnostic.size;
//            convertedValues.append(convertValue(diagnostic));
        }
        reader.close();
        dataFile.close();

        displayGammaAndEpsilon (rawReadings, numBits);
        displayO2andCO2Ratings (rawReadings, numBits);


    }


    proc main () {
        processFile();
    }
