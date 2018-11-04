import Foundation

///Массив для хранения итогового результата. Узлов с указанием символа, частоты символа и префиксоного кода
var resultNodes = [Node]()

///Проход по всему дереву, вычисление кода для символа и сохиранение его в массив результатов
func preOrder(node: Node?, code: String?) {
    guard let node = node else {
        return
    }
    if node.leftChild == nil && node.rightChild == nil {
        node.code = code ?? ""
        resultNodes.append(node)
    }
    let encode = code ?? ""
    preOrder(node: node.leftChild, code: encode + "0")
    preOrder(node: node.rightChild, code: encode + "1")
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

//Поиск повторяющихся символов
let charArray = Array(text)
let countOfCharInText = text.count
var dictinary = [Character: Int]()
for chr in charArray {
    let count = (dictinary[chr] ?? 0) + 1
    dictinary[chr] = count
}

//Инициализация массива узлов
var nodes = [Node]()

//Создаем для каждого символа свой узел
for object in dictinary {
    let node = Node(symbol: object.key, count: object.value)
    nodes.append(node)
}

//Сортируем узлы
nodes.sort(by: { $0.count < $1.count })

//Формирование дерева по алгоритму Хаффмана
while (nodes.count != 1) {
    let left = nodes[0]
    let right = nodes[1]
    nodes.removeFirst(2)

    let newNode = Node(left: left, right: right)
    nodes.append(newNode)
    
    nodes.sort(by: { $0.count < $1.count })
}

//Поиск решений
preOrder(node: nodes[0], code: nil)

//Сортировка решений по длине полученной последовательности кода
resultNodes.sort(by: { $0.code?.count ?? 0 < $1.code?.count ?? 0})

//Вывод результата в консоль
for object in resultNodes{
    print("Symbol: \(object.symbol); Freq: \(Float(object.count)/Float(countOfCharInText)); Code: \(object.code ?? ""); Length: \(object.code?.count ?? 0)")
}

