use IO;

var dataFile = open("day1input.txt", iomode.r);

var line: string;
var count: int = 0;


writeln ("Number of lines in the file: ", dataFile.lines().count());
for line in dataFile.lines() {
//    write("Data read: ", line);
    count += 1;
}
writeln ("Number of entries in file: ", count);

dataFile.close();