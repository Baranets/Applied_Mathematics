import Foundation

///Принимает на вход последовательность символов(строку (String)) разбивает на отдельные составляющие, считает количество различных символов в строке и формирует массив класса Entropy
func entropyOfSingleSymbol(text: String) -> [Entropy] {
    //Поиск повторяющихся символов
    let charArray = Array(text)
    var dictinary = [Character: Int]()
    for chr in charArray {
        let count = (dictinary[chr] ?? 0) + 1
        dictinary[chr] = count
    }

    //Инициализируем словари хранящие в себе "Вероятность встречи символа" и "Энтропию", а также переменную храняющую в себе кол-во символов в файле
    let countSymbols: Float = Float(text.count)
    var resualtEntropy = [Entropy]()
    
    //Вычисление вероятностей и энтропии
    for object in dictinary {
        let possibility = Float(object.value) / countSymbols
        let entropy = Entropy(sequenceSymbols: String(object.key), possibility: possibility)
        resualtEntropy.append(entropy)
    }
    
    return resualtEntropy
}

///Принимает на вход последовательность символов(строку (String)) разбивает на отдельные составляющие, считает количество различных пар символов в строке и формирует массив класса Entropy
func entropyOfCoupleSymbols(text: String) -> [Entropy]  {
    //Поиск повторяющихся пар символов
    let charArray = Array(text)
    var dictinary = [String: Int]()
    for i in 0 ..< charArray.count - 1 {
        let key = String(charArray[i]) + String(charArray[i + 1])
        let count = (dictinary[key] ?? 0) + 1
        dictinary[key] = count
    }
    
    //Инициализируем словари хранящие в себе "Вероятность встречи символа" и "Энтропию", а также переменную храняющую в себе кол-во символов в файле
    let countSymbols: Float = Float(text.count)
    var resualtEntropy = [Entropy]()
    
    //Вычисление вероятностей и энтропии
    for object in dictinary {
        let possibility = Float(object.value) / countSymbols
        let entropy = Entropy(sequenceSymbols: String(object.key), possibility: possibility)
        resualtEntropy.append(entropy)
    }
    
    return resualtEntropy
}

///Переменная храняющая путь к файлу
let file = "File.txt" //User\max\Documents\File.txt
///Переменная хранящая содержимое файла (текст в формате String)
var text = ""

//Чтение из файла
if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
    let fileURL = dir.appendingPathComponent(file)
    do {
        text = try String(contentsOf: fileURL, encoding: .utf8)
    } catch {
        print("error")
    }
}

//Вывод результата работы вычисления энтропии для одиночных символов
for object in entropyOfSingleSymbol(text: text).sorted(by: {$0.possibility < $1.possibility}){
    print("Symbol: \(object.sequenceSymbols); Possibility: \(object.possibility); Entropy: \(object.entropyValue)")
}

//Разделение выводов двумя пустыми строчками
print("\n")

//Вывод результата работы вычисления энтропии для пар символов
for object in entropyOfCoupleSymbols(text: text).sorted(by: {$0.possibility < $1.possibility}){
    print("Symbols: \(object.sequenceSymbols); Possibility: \(object.possibility); Entropy: \(object.entropyValue)")
}


