package body AdaptiveQuad is
    function SimpsonsRule(a, b:integer) return float is
        c, h3:float;
    begin
        c := (a+b) / 2.0;
        h3 = abs(b-a) / 6.0
        return h3*(f(a) + 4.0*f(c) + f(b))
    end SimpsonsRule;

    function RecAQuad(a, b:integer, eps, whole:float) return float is
        c, left, right:float; 
        result1, result2:float;
    begin
        c = (a+b) / 2.0;
        left = SimpsonsRule(a,c);
        right = SimpsonsRule(c,b);
        if (abs(left + right - whole) <= 15*eps) then
            return left + right + (left + right - whole)/15.0;
        end if

        task recurTask1;
        task body recurTask1 is
        begin
            result1 = RecAQuad(a, c, eps/2.0, left);
        end recurTask1;
 
        task recurTask2;
        task body recurTask2 is
        begin
            result2 = RecAQuad(c, b, eps/2.0, right);
        end recurTask2;

        return result1 + result2;
    end RecAQuad;

    function AQuad(a, b: integer, eps: float) return float is
    begin
        return RecAQuad(a, b, eps, SimpsonsRule(a,b));
    end AQuad;
end AdaptiveQuad;