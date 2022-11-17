use IO;
use List;

config const file = "day5input.txt";
config const debug = true; 
config const mapSize = 10;

    record coordinate {
        var x: int;
        var y: int; 
        proc readThis (f) throws {
            x = f.read(int);
            f.readLiteral(",");
            y = f.read(int);
        }
        proc writeThis (f) {
            f.write("X = ", x, " Y = ", y);
        }
    }

    proc processFile () throws {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var lines: list ((coordinate(), coordinate()));
//        var lines:list (((int,int),(int,int)));
//        var lines: list ((coordinate(), coordinate()));
        var p1, p2: coordinate();
        var endOfFile: bool = false;
        var validData: bool;  
        do {
            try { 
                p1 =  new coordinate();
                p2 =  new coordinate();
                validData = reader.read (p1);
                if (validData) {
                    writeln ("Left = ", p1);
                    writeln ("P1:  ", p1.x, ", ", p1.y);
                    reader.readLiteral("->");
                    validData = reader.read (p2);
                    if (validData) {
                        writeln ("Right = ", p2);
                        //store P1 and P2
                        lines.append ((p1,p2));
                    } else {
                        endOfFile = true;
                    }
                } else {
                    endOfFile = true;
                }
            } catch e:EofError {
                writeln("End of File found");
                endOfFile = true; 
            }
        } while (!endOfFile);

        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
