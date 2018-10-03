import Foundation

class Node {
    var symbol: Character
    var count:  Int
    var code:   String?
    var leftChild:  Node?
    var rightChild: Node?
    
    init(symbol: Character, count: Int) {
        self.symbol = symbol
        self.count  = count
    }
    
    init(left: Node, right: Node) {
        self.symbol     = Character("*")
        self.count      = left.count + right.count
        self.leftChild  = left
        self.rightChild = right
    }
}
