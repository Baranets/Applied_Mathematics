import Foundation

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

//Поиск повторяющихся символов
let charArray = Array(text)
var dictinary = [Character: Int]()
for chr in charArray {
    let count = (dictinary[chr] ?? 0) + 1
    dictinary[chr] = count
}

//Инициализируем словари хранящие в себе "Вероятность встречи символа" и "Энтропию", а также переменную храняющую в себе кол-во символов в файле
let countSymbols: Float = Float(text.count)
var dictinaryPossibility = [Character: Float]()
var dictinaryEntropy = [Character: Float]()

//Вычисление вероятностей и энтропии
for object in dictinary {
    let possibility = Float(object.value) / countSymbols
    dictinaryPossibility[object.key] = possibility
    dictinaryEntropy[object.key] = log2f( 1 / possibility )
}

//Вывод результата работы программы
print(dictinary)
print(dictinaryPossibility)
print(dictinaryEntropy)

