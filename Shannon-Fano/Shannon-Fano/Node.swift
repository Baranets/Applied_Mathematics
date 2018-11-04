import Foundation

class Node: CustomStringConvertible {
    var symbol:      Character
    var probability: Float
    var code:        String?
    
    init(symbol: Character, probability: Float) {
        self.symbol      = symbol
        self.probability = probability
    }
    
    var description: String { return "Node: Symbol = \(self.symbol); Probability: \(self.probability); Code: \(self.code ?? ""); Length: \(self.code?.count ?? 0)" }
}
