use IO;
use List;

config const file = "day10input.txt";
config const debug = true; 

    proc outputCrtImage (instructions: list (int)) {
        var x: int = 1;
        var crtLine: string;
        var pixel: int = 0;  
        var crtRow: int = 0;
        var cursorCenter: int = 0;

        for cycle in 0..instructions.size-1 {

            cursorCenter = cycle - crtRow*40;
            
            if ((cursorCenter== x-1) || (cursorCenter== x) || (cursorCenter==x+1)) then
                crtLine += '#';
            else
                crtLine += '.';

            pixel +=1; 

            if (pixel == 40) {
                writeln (crtLine);
                pixel = 0; 
                crtRow +=1;
                crtLine = "";
            }
            x += instructions[cycle];
        }
    }

    proc runClockCircuit (instructions: list (int)) {

        var signalStrength: [1..instructions.size+1] int;
        var x: int = 1;

        for cycle in 1..instructions.size {
        // Operation model: 
        //    Cycle and Signal Strength is stored
            signalStrength[cycle] = x*cycle;
            writeln ("Cycle: ", cycle, " Signal Strenght: ", x*cycle);   
        //    Add Value
            x += instructions[cycle-1];
        }
        var checks = [20, 60, 100, 140, 180, 220];
        var signalStrSum = 0;
        for check in checks {
            writeln ("Cycle : ", check, " Signal Strength: ", signalStrength[check]);
            signalStrSum += signalStrength[check];
        }
        writeln ("Total Signal Strength: ", signalStrSum);
    }

    proc processFile (){
        var instructions:list(int);

        var dataFile = open(file, ioMode.r);
        var reader = dataFile.reader();
        var oper, strVal: string;
        var val: int; 
        while (reader.readLine(oper, -1, true)) do {
            if (oper == "noop") {
                instructions.pushBack(0);
            } else {
                val=oper.strip("addx\t\r\n "):int;
                instructions.pushBack(0);
                instructions.pushBack(val);
            }
        }
        reader.close();
        dataFile.close();
        
        if (debug) then 
            writeln(instructions);

        runClockCircuit(instructions); 
        outputCrtImage(instructions);   

    }

    proc main () {
        processFile();
    }
