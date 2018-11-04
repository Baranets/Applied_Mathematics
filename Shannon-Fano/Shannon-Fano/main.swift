import Foundation

//Инициализируем массив с результатами работы программы
var resultNodes = [Node]()

///Разделение входного массива на два приблизительно равных по вероятности массива
func encodingShannonFano(nodes: [Node]) {
    
    //Выйти из рекурсии если в массиве остался один элемент
    guard nodes.count != 1 else {
        return
    }
    
    //Инициализируем массив левой и правой ветки
    var leftNodes  = [Node]()
    var rightNodes = [Node]()
    
    //Инициализируем счетчики суммарных вероятностей символов
    var leftSum : Float = 0.0
    var rightSum: Float = 0.0
    
    //Разделение массива (ветки) на два приблизительно равных
    for object in nodes {
        if leftSum <= rightSum {
            //Добавляем 0 в кодирование левого узла
            object.code = (object.code ?? "") + "0"
            
            //Добавлем объект в узел
            leftNodes.append(object)

            //Прибавляем вероятность к счетчику
            leftSum += object.probability
        } else {
            //Добавляем 1 в кодирование правого узла
            object.code = (object.code ?? "") + "1"
            
            //Добавлем объект в узел
            rightNodes.append(object)
            
            //Прибавляем вероятность к счетчику
            rightSum += object.probability
        }
    }

    //Рекурсивный запуск функции для кодирования символов
    encodingShannonFano(nodes: leftNodes)
    encodingShannonFano(nodes: rightNodes)
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
        exit(1) //выход из программы в случае если не удалось прочитать из файла
    }
}

//Поиск повторяющихся символов
let charArray = Array(text)
var dictinary = [Character: Int]()

for chr in charArray {
    let count = (dictinary[chr] ?? 0) + 1
    dictinary[chr] = count
}

///Количество символов в сообщении
let countOfCharInText = text.count

//Фирмируем массив первоначальных узлов
for object in dictinary {
    let probability = Float(object.value) / Float(countOfCharInText)
    let node = Node(symbol: object.key, probability: probability)
    resultNodes.append(node)
}

//Сортировка массив в порядке убывания вероятности появления
resultNodes.sort(by: { $0.probability > $1.probability })

//Содирование массива символов
encodingShannonFano(nodes: resultNodes)

//Вывод результата
print("--- T A B L E ---")
for object in resultNodes {
    print(object)
}

