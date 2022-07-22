use IO;
use List;

config const file = "day4input.txt";
config const debug = true; 

    // This iterator reads the 5 x 5 cards via the reader passed in as a parameter. 
    // It then builds a card that includes the number and a flag to indicate the
    // number has been called. 
    iter readCards (fr) {
        var numbersOnly: [1..5, 1..5] int;
        var board: [1..5, 1..5] (int, bool); 
        do {
            const success = fr.read(numbersOnly);
            if (success) then {
                for rowCol in {1..5, 1..5} do {
                    board[rowCol](0) = numbersOnly[rowCol];
                }
                yield board;
            }
        } while success;
    } 
    // The file format for this day's puzzle is a comma separated list of bingo numbers followed by a series of
    // 5 x 5 arrays of bingo cards. 

    // The file reading portion at the beginning is based on some code I was sent
    // from Brad to understand how the iter function works with yield to return an 
    // array of bingo cards (5x5 arrays)
    
    proc processFile () {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();

        var numbers: list(int);
        var endOfFile: bool = false; 
        do {
            const num = reader.read(int);
            numbers.append (num); 
            try {
                reader.readf(",");
            } catch {
                endOfFile = true; 
            }

        } while (!endOfFile);

        if (debug) then 
            writeln (numbers);

//        var bingoCards = readCards(reader);
        var bingoCards: list ([1..5, 1..5](int,bool));
        var cards = readCards(reader);
        bingoCards.init(cards); 
        if debug then {
            writeln ("Number of bingo cards: ", bingoCards.size);
            for b in bingoCards {
                writeln(b, "\n");
                // In this case the iterator rc, will allow additional processing 
                // upon each cell in the array. 
                var sum = + reduce [rc in {1..5, 1..5}] b[rc](0);
                writeln ("Board sum is: ", sum);
            }
        }
        reader.close();
        dataFile.close();

        const (winner, number) = playBingo (numbers, bingoCards);
        if debug then
            writeln ("Winning number: ", number, "\nWinning card: ", winner);
        calculateResults (winner, number); 
    }

    proc playBingo (numbers: list(int), cards: list([1..5, 1..5](int, bool))) {
        // So we are going to create a list of winning cards 
        var winningCards:list(([1..5, 1..5](int, bool),int)); 
        for number in numbers {
            for card in cards {
                for rowCol in {1..5, 1..5} {
                    if (number == card[rowCol](0)) then
                        card[rowCol](1) = true;
                }
            }
            // Did this number result in a winner? 
            const (winner,card) = checkWinner(cards);
            if (winner) then {
                winningCards.append((card, number));
                return (card, number);
            }
        }        
        halt("No winner found and we are out of numbers");
    }

    proc checkWinner (cards : list([1..5,1..5](int,bool))) : (bool, [1..5,1..5] (int,bool)) { 
        var emptyCard: [1..5,1..5](int,bool);
        for card in cards {
            // We check each row to see if each number has been picked
            for row in 1..5 do {
                if (& reduce [c in {1..5}] card[row, c](1)) then
                    return (true, card);
            }

            // Then we check each column to do the same thing
            for col in 1..5 do {
                if (& reduce [r in {1..5}] card[r, col](1)) then
                    return (true, card); 
            }
        }
        return (false, emptyCard);
    }

    proc calculateResults (card : [1..5, 1..5](int,bool), number: int) {
        var boardSum = + reduce [rc in {1..5, 1..5}] if (card[rc](1)) then 0 else card[rc](0);
        writeln ("Board sum is: ", boardSum);
        writeln ("Final result is: ", boardSum *number);

    }

    proc main () {
        processFile();
    }
