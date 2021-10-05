
 
// MARK: - Задача #1.
 
/*  Придумайте именованные типы Swift, подбирая лучшие абстракции. Объявите свойства и методы в них.
    Статический анализатор подскажет, если вы забудете кое-что ('Type annotation missing...').
    На предупреждения о том, что в enum нельзя объявлять хранимые свойства и на необходимость инициализаторов в class, пока не обращайте внимания. */


// MARK: Enum, подойдет для перечесления блюд для которых необходим определенный столовый прибор.
enum PurposeOfTheCutleryForFood: String {
    case solidFood = "для твердой пищи"
    case liquidFood = "для жидкой пищи"
}

// MARK: Protocol, подойдет для создания контракта, для всех столовых приборов
protocol CutleryProtocol {
    var material: String { get }
    var isInternedForTheDish: PurposeOfTheCutleryForFood { get }
    
    func takeInHand()
    func removeFromHand()
}

// MARK: Struct для конкретного столового прибора, у которого нам не нужно наследование. Для вилки в данное случае наследование использовать не будем.
struct Fork: CutleryProtocol {
    var material: String
    var isInternedForTheDish: PurposeOfTheCutleryForFood
    var length: Double = 12
    var wedht: Double = 2
    
    func takeInHand() {}
    func removeFromHand() {}
}

// MARK: Class, для конкретного столового прибора. Мы создадим обычную столовую ложку, и далее сможем создать абстрактоного наследника - чайную ложку.
class TableSpoon: CutleryProtocol {
    var material: String = "железо"
    var isInternedForTheDish: PurposeOfTheCutleryForFood = .liquidFood
    
    func takeInHand() {}
    func removeFromHand() {}
}

class Teaspoon: TableSpoon {
    func toPlaceTea() {}
}





// MARK: - Задача 2*

/*  Напишите по 2 примера композиции и агрегации из реального мира, без использования кода.
    Каждому примеру дайте объяснения почему это композиция или агрегация. */
