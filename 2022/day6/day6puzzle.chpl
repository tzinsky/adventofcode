use IO;
use Set;

config const file = "day6input.txt";
config const debug = true; 

    proc processFile ():string{
        var retString: string; 
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        reader.readLine(retString,-1,true);
        reader.close();
        dataFile.close();
        return retString; 
    }

    proc repeatChars (str:string): bool {
        var strSet: set (string); 
        for ch in str.items() {
            strSet.add (ch);
        }
        return (strSet.size == str.size);
    }

    proc findMarker (str:string, winSize:int): int {
        var marker: int = -1; 
        var window:string; 
        var match: bool; 
        for idx in 0..<str.size {
            if (idx+winSize<str.size) {
                window = str.this(idx..<idx+winSize);
                if (debug) then 
                    writeln ("Character for ", str[idx], " Window to check: ", window);
                // Determine if repeated characters within this window 
                if (repeatChars(window)) {
                    marker = idx+winSize;
                    break; 
                }
                // If not - we take the ending index and add 1 to get the answer. 
            }
        }
        return marker;
    }


    proc main () {
        var dataStream: string = processFile();
        if debug then 
            writeln (dataStream);
        var marker: int = findMarker (dataStream, 4);
        writeln ("Marker is after character: ", marker);
        var msgMarker: int = findMarker (dataStream, 14);
        writeln ("Message marker is after character: ", msgMarker);
    }
