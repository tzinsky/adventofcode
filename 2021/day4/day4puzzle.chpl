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

        var bingoCards: list ([1..5, 1..5](int,bool));
        var cards = readCards(reader);
        bingoCards.init(cards); 
        reader.close();
        dataFile.close();

        var winners = playBingo (numbers, bingoCards);
        if debug then {
            for b in winners {
                writeln (b, "\n");
            }
        }

        if debug then       
            writeln ("First winning card: \n", winners.first());
        writeln("First winning card results are: ");
        calculateResults(winners.first()(0), winners.first()(1));

        if debug then 
            writeln ("Last winning card:  \n", winners.last());
        writeln("Last winning card results are:  ");
        calculateResults(winners.last()(0), winners.last()(1));

    }

    proc playBingo (numbers: list(int), cards: list([1..5, 1..5](int, bool))) {
        // So we are going to create a list of winning cards 
        var winningCards:list(([1..5, 1..5](int, bool),int)); 
        var bingoCards: list([1..5, 1..5](int, bool));
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

        for number in numbers {
            if debug then 
                writeln ("Playing number: ", number, "\nNumber of cards to play ", bingoCards.size);
            for card in bingoCards {
                for rowCol in {1..5, 1..5} {
                    if (number == card[rowCol](0)) then
                        card[rowCol](1) = true;
                }
            }
            // Did this number result in a winner? 
            // Can there be multiple winners on a the same number? Yes - yes there can be...  
            // So we cull them all at once...
            do {
                const (winner,card) = checkWinner(bingoCards);
                if (winner) then {
                    if debug then
                        writeln ("Adding winner... ", number);
                    winningCards.append((card, number));
                    bingoCards = fixupCardList(bingoCards, card);
                }                
            } while winner;

        }
       
        return winningCards;
    }

    proc fixupCardList (cards: list([1..5, 1..5](int, bool)), remove: [1..5, 1..5](int, bool))
    {
        var removeNum: int = -1; 
        var items: list([1..5, 1..5](int, bool));
        items.init(cards);

        for idx in 0 .. items.size-1 do {
            if (items.getValue(idx).equals(remove)) then {
                removeNum = idx;
            }
        }
        if (removeNum != -1) then 
           items.pop (removeNum);
        return items; 
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
