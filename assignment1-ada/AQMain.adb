with AdaptiveQuad;
use AdaptiveQuad;
with Text_Io;  -- always need these two lines for printing
use Text_Io;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;
with Ada.Numerics.Generic_Elementary_Functions;

procedure AQMain is
    package Int_Io is new Integer_Io(Integer);  -- always need these two lines
    use Int_Io;                                 -- to print integers
    package FloatFunctions is new Ada.Numerics.Generic_Elementary_Functions(Float);
    use FloatFunctions;

    Epsilon:float := 0.000001;

    function MyF(x:float) return float is
    begin -- MyF
       return Sin(x*x); 
    end MyF;

    package MyAdaptiveQuad is new AdaptiveQuad(MyF);
    use MyAdaptiveQuad;

begin -- AQMain

    for i in 1..5 loop
        task ReadPairs;
        task body ReadPairs is
            a, b:integer;
        begin
            Get(a);
            Get(b);
            ComputeArea.Go(a, b);
        end ReadPairs;

        task ComputeArea is
            entry Go(x, y:integer);
        task body ComputeArea is
            a, b:integer;
            result:float;
        begin
            accept Go(x, y:integer)
                a := x;
                b := y;
            end Go;
                result := AQuad(a, b, Epsilon);
                PrintResults.Print(a, b, result);
        end ComputeArea;

        task PrintResults is
            entry Print(x, y:integer, z:float);
        end PrintResults;
        task body PrintResults is
            a, b:integer;
            result:float;
        begin
            accept Print(x, y:integer, z:float) do
                a := x;
                b := y;
                result := z;
            end Print;
            Put("The area under sin(x^2) for x = "; Put(a); Put" to "; Put(b); Put(" is "); Put(result); New_Line;
        end PrintResults;

    end loop;
    
end AQMain;