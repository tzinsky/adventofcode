use IO;
use List;

config const file = "recorddata.txt";

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

    var dataFile = open(file, iomode.r);
    var reader = dataFile.reader();
    var endOfFile: bool = false;
    var p1: coordinate();
    do {
        try { 
            p1 =  new coordinate();
            p1 = reader.read (coordinate());
            writeln(p1);
        } catch e:EofError {
            writeln("End of File found");
            endOfFile = true; 
        } catch {
            writeln("Other error");
            endOfFile = true; 
        }
    }
    while (!endOfFile);
    reader.close();
    dataFile.close();
