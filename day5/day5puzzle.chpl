use IO;
use List;

config const file = "day5input.txt";
config const debug = true; 


    proc processFile (){
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
