class Node:
    def __init__(self,data) -> None:
        self.data = data
        self.left = None
        self.right = None

class rAdd:
    def __init__(self,curr, data) -> Node:
        self.curr = curr
        self.data = data 


class bst:
    def __init__(self,root) -> None:
        self.root = Node(root)

    def add(self, data):
        self.root = rAdd(bst, data)

        