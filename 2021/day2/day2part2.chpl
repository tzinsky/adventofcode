    use IO;
    use IO.FormattedIO;
    use List;

    config const file = "day2input.txt";

    var dataFile = open(file, iomode.r);
    var reader = dataFile.reader();

    enum navigation {forward, down, up};
    
    var direction: navigation; 
    var distance: int = 0; 
    var aim: int = 0;
    var depth: int = 0;
    var travelDistance: int = 0;

    while (reader.readf("%s %i", direction, distance)) {

        if (direction == navigation.forward) {
           travelDistance += distance;
           depth += distance*aim;
        }
        
        if (direction == navigation.down) then 
            aim += distance;

        if (direction == navigation.up) then 
            aim -= distance; 
    }


    writeln ("Sub travelled:  ", travelDistance, " and is now at depth: ", depth);
    writeln ("Final position is: ", travelDistance*depth);
    reader.close();
    dataFile.close();
