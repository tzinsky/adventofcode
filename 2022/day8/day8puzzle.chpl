use IO;
use List;

config const file = "day8input.txt";
config const debug = true; 

    proc convert2Array (vals:list(string)): [] int {
        var retArray: [0..<vals[0].size, 0..<vals.size] int; 

        for row in 0..<vals.size {
            for col in 0..<vals[0].size {
                retArray [row,col] = vals[row][col]:int;
            }
        }
        return retArray; 
    }

    proc processFile ():[] int {
        var mapLine: string; 
        var treeList: list (string);
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        while (reader.readLine(mapLine, -1, true)){
            treeList.append(mapLine);
        }

        reader.close();
        dataFile.close();
        
        var mapArray = convert2Array(treeList); 
        if (debug) then 
            writeln (mapArray);
        return mapArray;
    }

    //  Visibility is determined through the following formula: 
    //      + all trees on the perimeter of the forest (maxRow * maxCol)
    //  Then we look at each tree to determine if its visible to left: 
    //      0..<row, col
    //  Above: 
    //      row, 0..<col
    //  Right: 
    //      row+1..<maxRow, col
    //  Below: 
    //      row, col+1..<maxCol 
    proc countVisibleTrees (treeMap:[] int): int {
        var mapDims = treeMap.dims();
        var retVal:int = 2* (mapDims(0).high + mapDims(1).high);
        for row in 1..<mapDims(0).high {
            for col in 1..<mapDims(1).high {
                var height = treeMap[row,col];
                if (&& reduce (treeMap[0..<row, col] < height) || 
                    && reduce (treeMap[row, 0..<col] < height) ||
                    && reduce (treeMap[row+1.., col] < height) || 
                    && reduce (treeMap[row, col+1..] < height)) then
                        retVal +=1;     
            }
        }
        return retVal; 
    }

    proc main () {
        var treeMap = processFile();
        var visibleTrees: int = countVisibleTrees(treeMap);
        writeln ("Visible trees: ", visibleTrees); 
    }
