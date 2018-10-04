import Foundation

///Предназначен для хранения информации для символа(последовательность символа(ов), вероятность встречи данного символа, а также вычисления энтропии)
class Entropy {
    
    let sequenceSymbols: String
    let possibility:     Float
    var entropyValue:    Float {
        get {
            return log2f( 1 / self.possibility )
        }
    }
    
    init(sequenceSymbols: String, possibility: Float) {
        self.sequenceSymbols = sequenceSymbols
        self.possibility     = possibility
    }
    
}
