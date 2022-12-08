use IO;
use List;

config const file = "day7input.txt";
config const debug = true; 
config const sizeThreshold = 100000;
config const totalDriveSpace = 70000000;
config const updateSpace = 30000000;
 

    class Directory {
        var name: string;
        var subDirs:  list (owned Directory);
        var parent: borrowed Directory?;
        var sizes:int;
        var totalDirectorySize: int; 
    }

    proc processFile (): list (string) {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var fileList: list(string);
        var inputLine:string;
        while (reader.readLine(inputLine, -1, true)) {
            fileList.append(inputLine);
        }
        reader.close();
        dataFile.close();
        return fileList;

    }

    proc parseClassCommands (commandList:list(string)) {

        var driveLayout = new Directory("/", new list (owned Directory), nil, 0, 0);
        var dirTraverse: borrowed Directory? = driveLayout;   
        for cmd in commandList {
            var subCmd = cmd.split();
            if (subCmd[0] == "$") {
                if (subCmd[1] == "cd") {
                    if (subCmd[2] == "/") {
                        dirTraverse = driveLayout; 
                    } if (subCmd [2] == "..") {
                        dirTraverse = dirTraverse!.parent;
                    } else {
                        for subDir in dirTraverse!.subDirs {
                            if (subDir.name == subCmd[2]) {
                                dirTraverse = subDir; 
                                break;
                            }
                        }
                    }
                }
            } else {
                if (subCmd[0] == "dir") {
                    dirTraverse!.subDirs.append(new Directory(subCmd[1], new list (owned Directory),dirTraverse!, 0, 0));
                } else {
                    dirTraverse!.sizes += subCmd[0]:int; 
                }
            }
        }
        computeTotalDirectorySizes(driveLayout);
        printDirectory(driveLayout, 0);
        var thresholdTotal = findSumOfDirectoriesUnderSize (driveLayout, sizeThreshold);
        writeln ("Directory totals under Threshold:   ", thresholdTotal);

        var availableSpace = totalDriveSpace - driveLayout.totalDirectorySize;
        writeln ("Current available space: ", availableSpace);
        var deleteSize = findSpaceforUpdate(driveLayout, updateSpace-availableSpace);
        writeln ("Directory size to be deleted: ", deleteSize);

    }
    
    proc printDirectory(dir:borrowed Directory?, indent:int) {

        for i in 0..<indent {
            write ("  ");
        }
        writeln ("Name: ", dir!.name, " File sizes: ", dir!.sizes, " Total Directory Size: ", dir!.totalDirectorySize);
        for subDir in dir!.subDirs {
            printDirectory(subDir,indent+1);
        }
    }

    proc computeTotalDirectorySizes (dir:borrowed Directory?) {
        dir!.totalDirectorySize = dir!.sizes;
        for subDir in dir!.subDirs {
            computeTotalDirectorySizes (subDir);
            dir!.totalDirectorySize += subDir.totalDirectorySize;
        }
    }

    proc findSumOfDirectoriesUnderSize (dir: borrowed Directory?, threshold: int): int {
        var retTotal: int = 0;
        for subDir in dir!.subDirs {
            retTotal += findSumOfDirectoriesUnderSize (subDir, threshold);
            if (subDir.totalDirectorySize <= threshold) {
                retTotal += subDir.totalDirectorySize;
            }
         } 
        return retTotal;
    }

    proc findSpaceforUpdate (dir: borrowed Directory?, spaceNeeded:int): int {
        var retTotal: int = updateSpace; 
        for subDir in dir!.subDirs {
            retTotal = min (retTotal, findSpaceforUpdate(subDir, spaceNeeded));
            if ((subDir.totalDirectorySize >= spaceNeeded) && (subDir.totalDirectorySize < retTotal)) {
                retTotal =subDir.totalDirectorySize;
            } 
        }
        return retTotal;
    }

    proc main () {
        var commandList: list(string) = processFile();
        parseClassCommands (commandList);        
    }
