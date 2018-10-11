import Foundation

///Символ кодируемый по методу арифметического кодирования
class SymbolCoding: CustomStringConvertible {
    
    ///Нижняя грань кодируемого символа
    let low:    Double
    ///Верхнаяя грань кодируемого символа
    let high:   Double
    
    var description: String { return "Low: \(low); High: \(high)" }
    
    init(low: Double, high: Double) {
        self.low    = low
        self.high   = high
    }
    
}
