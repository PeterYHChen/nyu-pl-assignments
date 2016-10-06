with Text_Io;  -- always need these two lines for printing
use Text_Io;
with Ada.Float_Text_IO;
use Ada.Float_Text_IO;

package body Adaptive_Quad is
    function SimpsonsRule(a, b:float) return float is
        c, h3:float;
    begin
        c := (a+b) / 2.0;
        h3 := abs(b-a) / 6.0;
        return h3*(f(a) + 4.0*f(c) + f(b));
    end SimpsonsRule;

    function RecAQuad(a, b, eps, whole:float) return float is
        c, left, right:float; 
        result1, result2:float;

        procedure Rec is
            task recurTask1;
            task recurTask2;

            task body recurTask1 is 
            begin
                result1 := RecAQuad(a, c, eps/2.0, left);
            end recurTask1;
            
            task body recurTask2 is 
            begin
                result2 := RecAQuad(c, b, eps/2.0, right);
            end recurTask2;
        begin -- Rec
            null;
        end Rec;

        begin
        c := (a+b) / 2.0;
        left := SimpsonsRule(a,c);
        right := SimpsonsRule(c,b);
        if (abs(left + right - whole) <= 15.0*eps) then
            return left + right + (left + right - whole)/15.0;
        else
            Rec;
        end if;

        return result1 + result2;

    end RecAQuad;

    function AQuad(a, b, eps:float) return float is
    begin
        return RecAQuad(a, b, eps, SimpsonsRule(a,b));
    end AQuad;
end Adaptive_Quad;