class OInt(xc: Int) extends Ordered[OInt] {
    val x: Int = xc

    def compare(that: OInt): Int = {
        if (this.x < that.x) {
            -1
        } else if (this.x > that.x) {
            1
        } else {
            0
        }
    }
    
    override def toString: String =
        "<" + x + ">"
}

abstract class OTree[T]() extends Ordered[OTree[T]] {
}

case class OLeaf[T <: Ordered[T]](mleaf: T) extends OTree[T] {
    val leaf: T = mleaf

    def compare(that: OTree[T]): Int = {
        // both are leafs
        if (that.isInstanceOf[OLeaf[T]]) {
            this.leaf.compare(that.asInstanceOf[OLeaf[T]].leaf)
        } else {
            -1
        }
    }

    override def toString: String = {
        "OLeaf(" + leaf.toString + ")";
    }
}

case class ONode[T <: Ordered[T]](mtreeList: List[OTree[T]]) extends OTree[T] {
    val treeList: List[OTree[T]] = mtreeList

    def compare(that: OTree[T]): Int = {
        // both are nodes
        if (that.isInstanceOf[ONode[T]]) {
            val tempList = that.asInstanceOf[ONode[T]].treeList
            var shortest = this.treeList.length
            if (shortest > tempList.length) {
                shortest = tempList.length
            }

            var com: Int = 0
            for (i <- 0 until shortest) {
                if (com == 0) {
                    com = this.treeList.apply(i).compare(tempList.apply(i))
                }
            }
            if (com != 0) {
                com
            } else if (this.treeList.length < tempList.length) {
                -1
            } else if (this.treeList.length > tempList.length) {
                1
            } else {
                0
            }
        } else {
            1
        }
    }

    override def toString: String = {
        var results: String = "ONode(List(";
        for (i <- 0 until treeList.length) {
            if (i > 0) {
                results = results + ", "
            }
            results = results + treeList.apply(i).toString
        }
        results.concat("))");
    }
}

object Part2 {
    def main(args: Array[String]) {
        test
    }

    def compareTrees[T](t1: OTree[T], t2: OTree[T]) = {
        if(t1.compare(t2) > 0){
            println("Greater")
        } else if (t1.compare(t2) < 0) {
            println("Less")
        } else {
            println("Equal")
        }
    }

    def test() {

        val tree1 = ONode(List(OLeaf(new OInt(6))))

        val tree2 = ONode(List(OLeaf(new OInt(3)),
                   OLeaf(new OInt(4)), 
                   ONode(List(OLeaf(new OInt(5)))), 
                   ONode(List(OLeaf(new OInt(6)), 
                          OLeaf(new OInt(7))))));

        val treeTree1: OTree[OTree[OInt]] = 
          ONode(List(OLeaf(OLeaf(new OInt(1)))))

        val treeTree2: OTree[OTree[OInt]] = 
          ONode(List(OLeaf(OLeaf(new OInt(1))),
             OLeaf(ONode(List(OLeaf(new OInt(2)), 
                      OLeaf(new OInt(2)))))))

        print("tree1: ")
        println(tree1)
        print("tree2: ")
        println(tree2)
        print("treeTree1: ")
        println(treeTree1)
        print("treeTree2: ")
        println(treeTree2)
        print("Comparing tree1 and tree2: ")
        compareTrees(tree1, tree2)
        print("Comparing tree2 and tree2: ")
        compareTrees(tree2, tree2)
        print("Comparing tree2 and tree1: ")
        compareTrees(tree2, tree1)
        print("Comparing treeTree1 and treeTree2: ")
        compareTrees(treeTree1, treeTree2)
        print("Comparing treeTree2 and treeTree2: ")
        compareTrees(treeTree2, treeTree2)
        print("Comparing treeTree2 and treeTree1: ")
        compareTrees(treeTree2, treeTree1)
    }
}