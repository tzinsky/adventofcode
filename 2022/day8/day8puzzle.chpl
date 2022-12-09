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

    // 
    // Create a scenic score array and then reduce that to get the right value
    // But first we must calculate that for each tree 
    // For each tree we will do the following 
    //  if current tree height >= tree we are checking 
    //      +1 to direction we are looking
    //
    //  over the following ranges:
    // 
    // Up:     row, 0..<col 
    // Left:   0..<row, col 
    // Right:  row+1..<maxRow, col
    // Down:   row, col+1<maxCol
    // 
    //  we then multiply those values together and store them in a scenic array in row,col
    // the retvalue is obtained by +max reduce scenicArray 

    proc getScenicScore (treeMap:[] int): int {
        var mapDims = treeMap.dims();
        var scenicArray: [mapDims(0), mapDims(1)] int; 
        for row in mapDims(0) {
            for col in mapDims(1) {
                var height = treeMap[row,col]; 

                var up, left, right, down: int = 0;
                for rc in 0..<col by -1 {
                    up +=1;
                    if treeMap[row,rc] >= height then 
                        break;
                }

                for rc in 0..<row by -1  {
                    left +=1;
                    if treeMap[rc, col] >= height then 
                        break; 
                }

                for rc in row+1..mapDims(0).high {
                    right +=1;
                    if treeMap[rc, col] >= height {
                        break;
                    }
                }

                for rc in col+1..mapDims(1).high {
                    down += 1;
                    if treeMap[row, rc] >= height {
                        break;
                    }
                }

//                var up = + reduce [rc in {0..<col}] if treeMap[row,rc] <= height then 1 else rc=col;
//                var left = + reduce [rc in {0..<row}] if treeMap[rc, col] <= height then 1 else rc=row;
//                var right = + reduce [rc in {row+1..mapDims(0).high}] if treeMap[rc, col] <= height then 1 else rc=mapDims(0).high;
//                var down = + reduce  [rc in {col+1..mapDims(1).high}] if treeMap[row, rc] <= height then 1 else rc=mapDims(1).high;
                writeln ("For : (", row,", ", col, ") - ", height, " UP: ", up, " LEFT: ", left, " RIGHT: ", right, " DOWN: ", down);
                scenicArray[row,col] = up*left*right*down;
            }
        }
        writeln (scenicArray); 
        return + max reduce scenicArray; 

    }


    proc main () {
        var treeMap = processFile();
        var visibleTrees: int = countVisibleTrees(treeMap);
        writeln ("Visible trees: ", visibleTrees); 
        var bestScenicScore = getScenicScore (treeMap); 
        writeln ("Bese scenic score: ", bestScenicScore);
    }
