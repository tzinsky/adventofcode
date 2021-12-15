use IO;

var dataFile = open("day1input.txt", iomode.r);

var reader = dataFile.reader();

var upCount: int = 0;
var downCount: int = 0;
var noChange: int = 0;
var prevReading: int = -1;
var currentReading: int; 

while (reader.read(currentReading)) {

  if (prevReading == -1) then 
    writeln (currentReading, " N/A no previous reading");
  else {
    if (currentReading > prevReading) {
      writeln (currentReading, " Increasing");
      upCount += 1;
    }
    else if (prevReading > currentReading) {
      writeln (currentReading,  " Decreasing");
      downCount += 1;
    }
    else{
      writeln (currentReading, " No Change");
      noChange += 1;
    } 
  }
  prevReading = currentReading; 

}

reader.close();
writeln ("Number increasing entries: ", upCount);
writeln ("Number of decreasing entries: ", downCount);
writeln ("Total entries: ", upCount+downCount);
dataFile.close();

