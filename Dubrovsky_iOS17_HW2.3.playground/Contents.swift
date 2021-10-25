import Foundation

//  MARK: - Задача #1.

/*  Тип для Замыкания: на входе два параметра Double, На Выходе Double.
 
    История: Вы разрабатываете спутник для полета на Европу (спутник Юпитера).
    В вашей команде два ученых по космодинамике. Вы даете каждому из них задачу расcчитать количество топлива для достижения спутником цели.
    Данные, которые они получают — это вес спутника и длина полета. Они должны вам предоставить свои алгоритмы расчета расхода топлива (это ваши замыкания).
    А вы по готовности алгоритмов делаете обработку данных и сравниваете результат (это ваша функция).

    Алгоритм выполнения:
    1) Написать функцию с входящим параметром — замыкание (тип указан выше). Функция должна выводить в консоль результат выполнения замыкания.
    2) Написать два замыкания (тип указан выше). Внутри должна быть математическая операция (на ваш выбор) над входящими значениями.
    3) Вызвать функцию для первого замыкания и потом для второго замыкания.
    4) Выполнить задание, не сокращая синтаксис языка.*/
 
 
 
 
 
//  MARK: - Задача #2.

/*  История: В вашем конструкторском бюро случилось ЧП и все компьютеры вышли из строя, но последние алгоритмы вы помните.
    Вы намерены добраться до ближайшего компьютера в соседнем селе и восстановить из своей памяти нужные данные. Ваша задача запомнить максимально краткую форму записи алгоритмов, чтобы все не смешалось в голове.

    Алгоритм выполнения:
    1) Представить задание 1 в сокращенном виде (см. пункт лекции "Сокращения для замыканий").*/





// MARK: - Задача #3.

/*  История: Пока вы добирались до села с компьютером, вам пришла в голову мысль своего алгоритма.
    Вы решили использовать свою функцию для проверки гипотезы и стали набирать алгоритм прямо в ней (реализация замыкания вместо параметра).

    Алгоритм выполнения:
    1) Вызвать функцию из задания 1, определив ей замыкание самостоятельно (не передавая).
    2) Объяснить, куда и почему исчезло ключевое слово ('param' - в примере) для параметра.

    Пример:
    func example(param: () -> Void) {
        // ...
    }
    
    example {
        // ...
    }*/













// MARK: - Код с лекции.

typealias SomeWork = (String, String) -> Void
let doSomeWork: SomeWork = { (nameOne: String, nameTwo: String) -> Void in
    print("First name: \(nameOne), nameTwo: \(nameTwo).")
}

let unsortedNumners = [1, 5, 6, 12, 4, 10, 5, 2, 1, 44, 56, 130, 1550]

func filter(numbers: [Int], closure: (Int) -> Bool) -> [Int] {
    var result: [Int] = []
    for number in numbers {
        if closure(number) {
            result.append(number)
        }
    }
    return result
}

//func isEven(number: Int) -> Bool {
//    return number % 2 == 0
//}

func isMouleOfTen(number: Int) -> Bool {
    return number % 10 == 0
}

let isEven = { (number: Int) -> Bool in
    return number % 2 == 0
}

let result = filter(numbers: unsortedNumners) { $0 % 5 == 0 }
print(result)




// В данном случае, компалятор посчитает сразу first, потом second, и потом зайдет в функцию
func isValid(first: Bool, second: Bool) -> Bool {
    return first && second
}

if isValid(first: 5 > 2, second: [1, 2, 3, 4, 5].count > 2) {
    print("IsValue true")
}

// Сдесь создана оптимизация за счёт замыкания, если first будет 0, то second высчитываться не будет.
// Т.к. сначала высчитается first, потом перейдет во внутрь, если first будет true, то начнется высчитывание замыкания.
func isValid_2(first: Bool, second: () -> Bool) -> Bool {
    return first && second()
}

if isValid_2(first: 5 > 2, second: { [1, 2, 3, 4, 5].count > 2 }) {
    print("IsValue_2 true")
}

// Если ставить @autoclosure, то фигурные скобки можно не ставить (компилятор сам поставит).
// Но аргумент second всё равно останется замыканием.
func isValid_3(first: Bool, second: @autoclosure () -> Bool) -> Bool {
    return first && second()
}

if isValid_3(first: 5 > 2, second: [1, 2, 3, 4, 5].count > 2) {
    print("IsValue_3 true")
}




class Boss {
    private let worker: Worker
    
    init(worker: Worker) {
        self.worker = worker
    }
    
    // При такой реализации (указания self.worker), классы будут ссылаться друг на друга.
    // Потому что у них друг на друга сильный ссылки, и сами они разорваться не могут.
    func start_1() {
        worker.completion = {
            print("Great worker \(self.worker.name). Pay money.")
        }
        worker.doSomeWork()
    }
    
    // Чтобы избежать этого, нужно использовать слабую ссылку
    // Слабая ссылка позволяет нам ссылаться на self, но счетчик ссылок увеличиваться не будет.
    // В таком случае, self внутри будет опциональным
    func start() {
        worker.completion = { [weak self] in   // Если написать [self] in, то это будет сильной ссылкой
            guard let sSelf = self else { return }
            print("Great worker \(sSelf.worker.name). Pay money.")
        }
        worker.doSomeWork()
    }
    
    deinit {
        print("Boss will be removed from memory.")
    }
}

class Worker {
    let name: String
    var completion: (() -> Void)?
    
    init(name: String) {
        self.name = name
    }
    
    func doSomeWork() {
        print("Do something.")
        // Long work ...
        completion?()   // Что значит ? перед скобками. Если completion не nil, то он вызовется.
    }
}

var worker: Worker? = Worker(name: "Josh")
var boss: Boss? = Boss(worker: worker!)
boss?.start()
boss = nil
worker = nil
