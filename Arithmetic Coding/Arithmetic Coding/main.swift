import Foundation

//Переменная храняющая путь к файлу
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

//Поиск повторяющихся символов
let charArray = Array(text)
var dictinary = [Character: Int]()
for chr in charArray {
    let count = (dictinary[chr] ?? 0) + 1
    dictinary[chr] = count
}

//Инициализируем массив для сохранения информации для формирования кодирования по алгоритму Хаффмана
let countSymbols = text.count
var dictinaryPossibility = [Character: Double]()

//Вычисление вероятностей и заполнение массива HuffmanData
for object in dictinary {
    let possibility = Double(object.value) / Double(countSymbols)
    dictinaryPossibility[object.key] = possibility
}

//Создаем убывающий по вероятностям массив
let sortedDictinaryPossibility = dictinaryPossibility.sorted(by: { $0.value > $1.value })
//Инициализируем массив символов с возможностью задать нижний и верхний интервал
var codedSymbols = [Character: SymbolCoding]()
var sumOfPossibility = 0.0

//Заполняем массив Символами с заданным интервалами
for object in sortedDictinaryPossibility {
    var high = sumOfPossibility + object.value
    if high > 1.0 {
        high = 1.0
    }
    codedSymbols[object.key] = SymbolCoding(low: sumOfPossibility, high: high)
    sumOfPossibility += object.value
}

/*Кодированеи последовательности*/
///Содержит нижнее
var oldLow    = 0.0
var oldHigh   = 1.0
var codedLow  = 0.0
var codedHigh = 1.0
for chr in charArray {
    codedLow  = oldLow + (oldHigh - oldLow) * codedSymbols[chr]!.low
    codedHigh = oldLow + (oldHigh - oldLow) * codedSymbols[chr]!.high
    oldLow    = codedLow
    oldHigh   = codedHigh
}

//Вывод таблицы кодирования символов
let sortedTable = codedSymbols.sorted(by: { $0.value.low < $1.value.low })
print("----- T A B L E -----")
for object in sortedTable {
    print("Symbol: \(object.key); Low: \(object.value.low); High: \(object.value.high)")
}

//Вывод результата кодирования
print("\n----- R E S U L T   E N C O D I N G -----")
print("Low: \(codedLow); High: \(codedHigh)")

//Декодирование последовательности
var message = ""
var code    = codedLow
for _ in 0 ..< countSymbols {
    for object in codedSymbols {
        if code >= object.value.low && code < object.value.high {
            message += String(object.key)
            code = (code - object.value.low) / (object.value.high - object.value.low)
            break
        }
    }
}

//Вывод результата декодирования
print("\n----- R E S U L T   D E C O D I N G -----")
print(message)
