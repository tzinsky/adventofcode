//module day2 {
    use IO;
    use IO.FormattedIO;
    use List;

    config const file = "day2input.txt";


    var dataFile = open(file, iomode.r);

    var reader = dataFile.reader();

    enum navigation {forward, down, up};

    var navEntry: (navigation, int);
    var direction: navigation; 
    var distance: int; 
    var depth: int = 0;
    var travelDistance: int = 0;

    var directions: list ((navigation, int), true);

    while (reader.readf("%s %i", direction, distance)) {
        navEntry = (direction, distance);
        directions.append(navEntry);
        if (direction == navigation.forward) then
            travelDistance += distance;
        
        if (direction == navigation.down) then
            depth += distance;

        if (direction == navigation.up) then 
            depth -= distance; 
    }
    // writeln (directions);

    writeln ("Sub travelled:  ", travelDistance, " and is now at depth: ", depth);
    writeln ("Final position is: ", travelDistance*depth);
    reader.close();
    dataFile.close();

//}
