import Foundation

class Hamming {
    
    ///Генерирует код Хемминга из исходной последовательности
    static func encode(code: [Int]) -> [Int] {
        
        //Создание и первичное заполнение последовательности
        var i = 0
        var parity_count = 0
        var generatedCode = [Int]()

        while (i < code.count) {
            if (pow(2, parity_count) == Decimal(i + parity_count + 1)) {
                generatedCode.append(0)
                parity_count += 1
            } else {
                generatedCode.append(code[i])
                i += 1
            }
        }

        //Вычисление и установка контрольных битов
        let parityBits = getParityBits(codeSequence: generatedCode, parity_count: parity_count)
        for object in parityBits {
            generatedCode[object.key] = object.value
        }
        
        return generatedCode
    }
    
    ///Декодирование последовательности Хемминга
    static func decode(code: [Int]) -> [Int] {
        var parity_count = 0
        var decodedSequence = [Int]()
        for i in 0 ..< code.count {
            if Decimal(i) == pow(2, parity_count) - 1 {
                parity_count += 1
                continue
            } else {
                decodedSequence.append(code[i])
            }
        }
        
        return decodedSequence 
    }
    
    ///Исправление ошибки в переданной последовательности. Возвращает исправленную последовательность
    static func errorCorrection(code: [Int]) -> [Int] {
       
        //Поиск ошибки в сообщении
        let errorPosition = errorSearch(code: code)

        //Исправление ошибки по полученной позиции
        var correctCode = code
        correctCode[errorPosition] = correctCode[errorPosition] == 1 ? 0 : 1
        
        return correctCode
    }
    
    ///Поиск ошибки в последовательноси Хемминга и возврашение позиции с ошибкой в записи
    static func errorSearch(code: [Int]) -> Int {
        //Определенеи количества бит проверки
        var receivedParityBits = [Int : Int]()
        var parityCouner = 0
        while pow(2,parityCouner) < Decimal(code.count) {
            let parityPosition = NSDecimalNumber(decimal: pow(2, parityCouner)).intValue - 1 // 0, 1, 3, 7, 15 ...
            receivedParityBits[parityPosition] = code[parityPosition]
            parityCouner += 1
        }
        
        ///Хранит в себе заново вычисленные котрольные биты из полученной последовательности
        let recomputatedParityBits = getParityBits(codeSequence: code, parity_count: parityCouner)
        var parityBitsDiffCounter = 0
        var errorPosition = 0
        for object in recomputatedParityBits {
            if object.value != receivedParityBits[object.key]{
                errorPosition += object.key
                parityBitsDiffCounter += 1
            }
        }
        errorPosition += parityBitsDiffCounter - 1
        
        print("Error in Bit: \(errorPosition)")
        return errorPosition
    }
    
    ///Вычимсляет котрольные биты последовательности
    private static func getParityBits(codeSequence: [Int], parity_count: Int) -> ([Int : Int]) {
        var parityBits = [Int : Int]()
        for i in 0 ..< parity_count {
            let parityInfluence = NSDecimalNumber(decimal: pow(2, i)).intValue  // 1, 2, 4, 8, 16 ...
            let parityPosition = parityInfluence - 1                            // 0, 1, 3, 7, 15 ...
            var counter = 0
            var j = parityPosition
            while (j < codeSequence.count) {
                for k in 0 ..< parityInfluence {
                    if (j + k) == parityPosition {
                        continue
                    }
                    guard (j + k) < codeSequence.count else {
                        break
                    }
                    counter += codeSequence[j + k]
                }
                j += parityInfluence * 2
            }
            parityBits[parityPosition] = counter % 2
        }
        return (parityBits)
    }
    
}
