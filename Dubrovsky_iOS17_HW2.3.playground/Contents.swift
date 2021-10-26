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



// Не совсем понял задание, поэтому сделал 2 функции, 1-ая с одним входящим параметром - замыкание.
func flightToEurope_1(closure: (Double, Double) -> Double) {
    print("[F1] По данной формуле, топлива для достижения Европы необходимо: \(closure(200, 30_000)) л.")
}

// 2-ая функция, добавляет к входным параметрам вес и длина полета.
func flightToEurope_2(satelliteWeight: Double, flightLength: Double, closure: (Double, Double) -> Double) {
    print("[F2] По данной формуле, топлива для достижения Европы необходимо: \(closure(satelliteWeight, flightLength)) л.")
}
 
let firstMathematicalCalculation = { (satelliteWeight: Double, flightLength: Double) -> Double in
    return flightLength / satelliteWeight * 100
}

let secondMathematicalCalculation = { (satelliteWeight: Double, flightLength: Double) -> Double in
    return satelliteWeight * flightLength / 40
}

print("ЗАДАЧА #1.")
flightToEurope_1(closure: firstMathematicalCalculation)
flightToEurope_1(closure: secondMathematicalCalculation)
print("------------------------------------------------")
flightToEurope_2(satelliteWeight: 200, flightLength: 30_000, closure: firstMathematicalCalculation)
flightToEurope_2(satelliteWeight: 200, flightLength: 30_000, closure: secondMathematicalCalculation)
print("------------------------------------------------\n")


 
 
 
//  MARK: - Задача #2.

/*  История: В вашем конструкторском бюро случилось ЧП и все компьютеры вышли из строя, но последние алгоритмы вы помните.
    Вы намерены добраться до ближайшего компьютера в соседнем селе и восстановить из своей памяти нужные данные. Ваша задача запомнить максимально краткую форму записи алгоритмов, чтобы все не смешалось в голове.

    Алгоритм выполнения:
    1) Представить задание 1 в сокращенном виде (см. пункт лекции "Сокращения для замыканий").*/



print("ЗАДАЧА #2.")
flightToEurope_1() { $0 / $1 * 100}
flightToEurope_1() { $0 * $1 / 40}
print("------------------------------------------------")
flightToEurope_2(satelliteWeight: 200, flightLength: 30_000) { $0 / $1 * 100}
flightToEurope_2(satelliteWeight: 200, flightLength: 30_000) { $0 / $1 * 100}
print("------------------------------------------------\n")





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


print("ЗАДАЧА #3.")
flightToEurope_1() { $0 * $1 / 10}

/*  Объясненение 2-го задания:
    Ключевое слово параметра - "param", убрано потому, что оно является замыканием, является последним и единственных входящим зымыканием, поэтому мы можем его вынести за круглые скобки, и написать реализацию closure внутри {}. */