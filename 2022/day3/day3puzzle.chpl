use IO;
use Set;
use List;


config const file = "day3input.txt";
config const debug = true; 

    proc findCommonItem (str1: string, str2: string): string {
        var retVal:string;
        var compareSet = new set (string, str2);
        do {
            for ch in str1.items() {
                if compareSet.contains(ch) then 
                    retVal = ch; 
            }
        } while (retVal.isEmpty());
        return retVal; 
    }

    proc convert2Value (ch:string): int {
        var subValue:int = "a".toByte() - 1 ;
        if (ch.isUpper()) then
            subValue = "A".toByte() - 27;

        return (ch.toByte() - subValue);
    }

    proc processFile (): list (string) {
        var rucksack:string; 
        var retList:list (string);
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        while (reader.readLine(rucksack, -1, true )) {
            if debug then 
                writeln (rucksack);
            retList.append(rucksack);
        }

        reader.close();
        dataFile.close();
        return retList; 

    }

    proc commonCompartments (sacks:list(string)) {
        var prioritySum: int = 0;
        for s in sacks {
            var compart1, compart2: string; 
            compart1 = s[0..<s.size/2];
            compart2 = s[s.size/2..<s.size];
            if debug then 
                writeln ("Compartment 1: ", compart1, " Compartment 2: ", compart2);
            var common = findCommonItem(compart1, compart2);
            if debug then  
                writeln ("Common item: ", common, " Int value:  ", convert2Value(common)); 
            prioritySum += convert2Value(common);
        }
        writeln ("Sum of priorities: ", prioritySum);

    }

    proc main () {
        var rucksacks:list(string);
        rucksacks = processFile();
        commonCompartments(rucksacks);
    }
