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

    proc findMarker (str:string): int {
        var marker: int = -1; 
        var window:string; 
        var match: bool; 
        for idx in 0..<str.size {
            if (idx+4<str.size) {
                window = str.this(idx..<idx+4);
                writeln ("Character for ", str[idx], " Window to check: ", window);
                // Determine if repeated characters within this window 
                match = false; 
                for ch in window.items() {
                    if (window.count(ch) > 1) then 
                        match = true;
                }
                // If not - we take the ending index and add 1 to get the answer. 
                if (!match) {
                    marker = idx+4;
                    break; 
                }

            }
        }
        return marker;
    }


    proc main () {
        var dataStream: string = processFile();
        if debug then 
            writeln (dataStream);
        var marker: int = findMarker (dataStream);
        writeln ("Marker is after character: ", marker);
    }
