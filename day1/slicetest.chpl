use IO;
use List;

proc sumListEntries(window:list(int)): int {
    var sum: int = 0;
    var listVal: int;

    for listVal in window do {
        sum +=listVal;
    }
    return sum;

}

proc sliceAndSumListData(winSize:int, dataList:list(int)) : list(int) {
    var i: int;
    var retList: list(int);
    var window: list(int);

    for i in 0 .. (dataList.size)-winSize  {
        window.init(dataList[i..i+winSize-1]);
        retList.append (sumListEntries(window));
        writeln ((i, window));
    }
    return retList;
}

proc main ()
{
    var dataFile = open("day1input.txt", iomode.r);
    var reader = dataFile.reader();

    var data:list(int);

    var currentReading: int; 

    while (reader.read(currentReading)) {
        data.append(currentReading);
    }

    writeln ("Read number from data file: ", data.size);

    reader.close();
    dataFile.close();

    var windowedData: list(int);
    windowedData = sliceAndSumListData (3, data);
    var aggEntry: int; 

    for aggEntry in windowedData {
        writeln ((windowedData.indexOf(aggEntry), aggEntry));
    }
    writeln ("Entries in aggregated list ", windowedData.size);
}