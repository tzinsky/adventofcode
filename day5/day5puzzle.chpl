use IO;
use List;

config const file = "day5input.txt";
config const debug = true; 

    record coordinate {
        var x: int;
        var y: int; 
        proc readThis (f) throws {
            x = f.read(int);
            f.readLiteral(",");
            y = f.read(int);
        }
        proc writeThis (f) {
            f.write("X = ", x, " Y = ", y);
        }
    }

    proc processFile () : list ((2*coordinate())) {
        var dataFile = open(file, iomode.r);
        var reader = dataFile.reader();
        var lines: list ((2*coordinate()));
        var p1, p2: coordinate();
        var endOfFile: bool = false;
        do {
            try { 
                p1 =  new coordinate();
                p2 =  new coordinate();
                p1 = reader.read (coordinate());
                reader.readLiteral("->");
                p2 = reader.read (coordinate());
                lines.append ((p1,p2));
            } catch  {
                endOfFile = true; 
            }
        } while (!endOfFile);
        reader.close();
        dataFile.close();
        return lines; 
    }

    proc mapSize (lines: list((2*coordinate()))): (2*int) {
        var x, y: int = 0;
        for line in lines {
            x = max(x, max(line[0].x, line[1].x));
            y = max(y, max(line[0].y, line[1].y));
        }
        if debug then
            writeln (" max x: ", x," max y: ", y); 
        return ((x, y));
    }

    proc buildLine (line: (2*coordinate())) : list(coordinate()){
        var xDiff = max(line[0].x, line[1].x) - min (line[0].x, line[1].x);
        var yDiff = max(line[0].y, line[1].y) - min (line[0].y, line[1].y);
        var numPoints = max (xDiff, yDiff);

        var points:list (coordinate()); 
        var pt: coordinate() = line[0];
        var xInc, yInc: int; 

        if (line[0].x == line[1].x) then
            xInc = 0;
        else if (line[0].x > line[1].x) then
            xInc = -1;
        else 
            xInc = 1;

        if (line[0].y == line[1].y) then
            yInc = 0;
        else if (line[0].y > line[1].y) then
            yInc = -1;
        else 
            yInc = 1;

        for idx in 0..numPoints do {
            points.append(pt);
            pt.x = pt.x + xInc; 
            pt.y = pt.y + yInc;
        }
        return points; 
    }

    proc plotLines (lines: list((2*coordinate())), mapDims:(2*int), bDiagonals: bool) {

        var map: [0..mapDims[0], 0..mapDims[1]] int; 

        for line in lines {
            if (((line[0].x == line[1].x || line[0].y == line[1].y )) || bDiagonals) {
                    if debug then
                        writeln ("Drawing line: ", line);
                    var points = buildLine(line); 
                    for  pt in points do {
                        map [pt.x, pt.y] +=1;
                    }
//
//                if (line[0].x != line[1].x) {
//                    for x in min(line[0].x, line[1].x)..max(line[0].x, line[1].x) {
//                       map[x, line[0].y] += 1;
//                    }
//                } else {
//                    for y in min(line[0].y, line[1].y)..max(line[0].y, line[1].y) {
//                        map[line[0].x, y] += 1;
//                    }
//                }
            }
        }
        if debug then
            writeln (map);
        calcVerticies(map, mapDims);
    }

    proc calcVerticies (map:[] int, mapDims:(2*int)) {
        var overlap: int = + reduce [rc in {0..mapDims[0], 0.. mapDims[1]}] if map[rc]>1 then 1 else 0;
        writeln ("Intersections: ", overlap); 
    }

    proc main () {
        var lines: list ((2*coordinate()));
        lines = processFile();
        var mapDims = mapSize(lines);
        plotLines(lines, mapDims, false);
        plotLines(lines, mapDims, true);
    }
