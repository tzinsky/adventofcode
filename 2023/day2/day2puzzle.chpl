use IO;
use List;

config const file = "dayXinput.txt";
config const debug = true; 


    proc processFile (){
        var dataFile = open(file, ioMode.r);
        var reader = dataFile.reader();

        reader.close();
        dataFile.close();

    }

    proc main () {
        processFile();
    }
