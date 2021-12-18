use IO;
use List;


var dataFile = open("testfile.txt", iomode.r);

var reader = dataFile.reader();

var prevReading: int;
var currentReading: int;
var readings: list(int); 

while (reader.read(currentReading)) {
    readings.append(currentReading);
}
writeln (readings);
writeln (prevReading);

reader.close();
dataFile.close();