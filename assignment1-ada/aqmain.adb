with adaptive_quad;
with Text_Io;  -- always need these two lines for printing
use Text_Io;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

procedure AQMain is
    package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
    use FloatFunctions;

    Epsilon:float := 0.000001;

    function MyF(x:float) return float is
    begin -- MyF
       return Sin(x*x); 
    end MyF;

    package MyAdaptiveQuad is new Adaptive_Quad(MyF);
    use MyAdaptiveQuad;

    task type ReadPairs is
        entry Go(index:integer);
    end ReadPairs;

    task type ComputeArea is
        entry Go(x, y:float; index:integer);
    end ComputeArea;

    task type PrintResults is
        entry Print(x, y, z:float);
    end PrintResults;

    ReadPairsTask : array(1..5) of ReadPairs;
    ComputeAreaTask : array(1..5) of ComputeArea;
    PrintResultsTask : array(1..5) of PrintResults;

    task body ReadPairs is
        a, b:float;
        idx:integer;
    begin
        accept Go(index:integer) do
        Get(a);
        Get(b);
        idx := index;
        end Go;
        ComputeAreaTask(idx).Go(a, b, idx);
    end ReadPairs;

    task body ComputeArea is
        a, b:float;
        result:float;
        idx:integer;
    begin
        accept Go(x, y:float; index:integer) do
            a := x;
            b := y;
            idx := index;
        end Go;
            result := aquad(a, b, epsilon);
            PrintResultsTask(idx).Print(a, b, result);
    end ComputeArea;

    task body PrintResults is
        a, b:float;
        result:float;
    begin
        accept Print(x, y, z:float) do
            a := x;
            b := y;
            result := z;
        end Print;
        Put("The area under sin(x^2) for x = "); Put(a); Put(" to "); Put(b); Put(" is "); Put(result); New_Line;
    end PrintResults;

begin -- AQMain

    for i in 1..5 loop
        ReadPairsTask(i).Go(i);
    end loop;
end AQMain;