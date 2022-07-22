use IO;
use List;

config const file = "array.txt";
config const debug = true; 

    // This iterator reads the 5 x 5 cards via the reader passed in as a parameter. 
    iter readCards (fr) {
        var numbersOnly: [1..5, 1..5] int;
        var board: [1..5, 1..5] (int, bool); 
        do {
            const success = fr.read(numbersOnly);
            if (success) then
                for rowCol in {1..5, 1..5} do {
                    board[rowCol](0) = numbersOnly[rowCol];
                }
                yield board;   
        } while success;
    } 

    proc processFile () {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var bingoCards = readCards(reader);
        for b in bingoCards do {
            writeln(b, "\n");
            // In this case the iterator rc, will allow additional processing 
            // upon each cell in the array. 
            var sum = + reduce [rc in {1..5, 1..5}] b[rc](0);
            writeln ("Board sum is:   ", sum);
        }

        reader.close();
        dataFile.close();
        sumColumns(bingoCards);

    }

    proc sumColumns (cards:[] [1..5,1..5](int, bool)) {
        for card in cards {
            for row in 1..5 {
                writeln (+ reduce [c in {1..5}] card[row, c](0)); 
            } 
            for column in 1..5 {
                writeln (+ reduce [r in {1..5}] card[r,column](0));
            }

        }


    }

    proc main () {
        processFile();
    }
