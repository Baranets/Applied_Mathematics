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

var codeArray = [Int]()
for chr in text {
    let number = Int(String(chr)) ?? 0
    codeArray.append(number)
}

print("Input Combination")
print(codeArray)
var array = Hamming.encode(code: codeArray)

print("Result Combination")
print(array)

print("Enter possition of the bit with error for detection from 0 to \(array.count - 1)")
var errorBit = -1
while (errorBit > array.count - 1 || errorBit < 0) {
    errorBit = Int(readLine() ?? "-1") ?? -1
}

print("Combination with Error")
array[errorBit] = array[errorBit] == 1 ? 0 : 1
print(array)

let correctCode = Hamming.errorCorrection(code: array)
print("Correct Combination")
print(correctCode)

print("Decoded Combination")
print(Hamming.decode(code: correctCode))


