Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(* Question 1: Merge function *)
fun merge [] L2 = L2
| merge L1 [] = L1
| merge (x::xs) (y::ys) =
if (x:int)<y then x::(merge xs (y::ys))
else y::(merge (x::xs) ys);


(* Question 2: Split function *)
fun split [] = ([],[])
| split [x] = ([x],[])
| split (x1::x2::xs) =
let
    val (ys, zs) = split xs
in
    ((x1::ys),(x2::zs))
end;


(* Question 3: MergeSort function *)
fun mergeSort [] = []
| mergeSort [x] = [x]
| mergeSort L = 
let
    val (xs, ys) = split L
in
    merge (mergeSort xs) (mergeSort ys)
end;


(* Question 4: Sort function *)
fun sort (op <) [] = []
| sort (op <) [x] = [x]
| sort (op <) L = 
let
    val (xs, ys) = 
        let
            fun split [] = ([],[])
            | split [x] = ([x],[])
            | split (x1::x2::xs) =
            let
                val (ys, zs) = split xs
            in
                ((x1::ys),(x2::zs))
            end;
        in
            split L
        end
in
    let
        fun merge [] L2 = L2
        | merge L1 [] = L1
        | merge (x::xs) (y::ys) =
        if x<y then x::(merge xs (y::ys))
        else y::(merge (x::xs) ys);
    in
        merge (sort (op <) xs) (sort (op <) ys)
    end
end;


(* Question 5: tree datatype declaration *)
datatype 'a tree = empty | leaf of 'a | node of 'a * 'a tree * 'a tree;


(* Question 6: labels function *)
fun labels empty = []
| labels (leaf x) = [x]
| labels (node (x, L, R)) = (labels L)@x::(labels R);


(* Question 7: replace function *)
fun replace (op ==) x y empty = empty
| replace (op ==) x y (leaf z) = 
    if x==z then 
        leaf y
    else
        leaf z
| replace (op ==) x y (node (z, L, R)) = 
    if x==z then 
        node (y, (replace (op ==) x y L), (replace (op ==) x y R))
    else 
        node (z, (replace (op ==) x y L), (replace (op ==) x y R));