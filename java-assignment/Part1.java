import java.util.ArrayList;
import java.util.List;

class ComparableList<T extends Comparable<T>> extends ArrayList<T> implements Comparable<ComparableList<T>> {

    public int compareTo(ComparableList<T> obj) {
        boolean flag = false;
        int shortest = this.size() < obj.size()? this.size() : obj.size();
        for (int i = 0; i < shortest; i++) {
            if (get(i).compareTo(obj.get(i)) == 0) {
                continue;
            } else {
                return get(i).compareTo(obj.get(i));
            }
        }
        if (size() < obj.size()) {
            return -1;
        }
        else if (size() > obj.size()) {
            return 1;
        }
        else {
            return 0;
        }
    }

    @Override
    public String toString() {
        StringBuffer results = new StringBuffer("[[");
        for (T element : this) {
            results.append(element.toString() + " ");
        }
        results.append("]]");
        return results.toString();
    }
}

class A implements Comparable<A> {
    private int x;
    public A (Integer x) {
        this.x = x;
    }

    @Override
    public int compareTo(A o) {
        if (x > o.x) {
            return 1;
        } else if (x < o.x) {
            return -1;
        } else {
            return 0;
        }
    }

    @Override
    public String toString() {
        return "A<" + x + ">";
    }
}

class B extends A {
    private int a, b;
    public B (Integer x, Integer y) {
        super(x + y);
        a = x;
        b = y;
    }

    @Override
    public int compareTo(A o) {
        return super.compareTo(o);
    }

    @Override
    public String toString() {
        return "B<" + a + "," + b + ">";
    }
}

class Part1 {
    public static void main(String[] args) {
        test();
    }

    public static void addToCList(A obj, ComparableList<A> list) {
        list.add(obj);
    }

    static void test() {
        ComparableList<A> c1 = new ComparableList<A>();
        ComparableList<A> c2 = new ComparableList<A>();
        for(int i = 0; i < 10; i++) {
            addToCList(new A(i), c1);
            addToCList(new A(i), c2);
        }

        addToCList(new A(12), c1);
        addToCList(new B(6,6), c2);

        addToCList(new B(7,11), c1);
        addToCList(new A(13), c2);

        System.out.print("c1: ");
        System.out.println(c1);

        System.out.print("c2: ");
        System.out.println(c2);

        switch (c1.compareTo(c2)) {
            case -1:
                System.out.println("c1 < c2");
                break;
            case 0:
                System.out.println("c1 = c2");
                break;
            case 1:
                System.out.println("c1 > c2");
                break;
            default:
                System.out.println("Uh Oh");
                break;
        }

    }
}