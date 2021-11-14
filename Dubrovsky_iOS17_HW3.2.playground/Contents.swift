import UIKit
import Foundation

/* https://github.com/netology-code/aios-homeworks/blob/master/3.2_homework.md */


// MARK: - ЧАСТЬ #1.

enum AccessoriesCar: String, CaseIterable {
    case tuning
    case tinting
    case alarmSystem
    case sportsWheels
    case sunroofInCeiling
    case leatherInterior
    case firstAidKit
    case fireExtinguisher
}

protocol Car {
    var model: String { get }
    var color: UIColor { get }
    var buildDate: Date { get }
    var price: Double { get set }
    var accessories: [AccessoriesCar] { get set }
    var isServiced: Bool { get set }
}




// MARK: - ЧАСТЬ #2.

protocol DealershipProtocol {
    var name: String { get }
    var showroomCapacite: UInt { get }
    var stockCars: [Car] { get set }
    var showroomCars: [Car] { get set }
    var cars: [Car] { get set }
    
    func offerAccesories(_: [AccessoriesCar])
    func presaleService(_: inout Car)
    func addToShowroom(_: inout Car)
    func sellCar(_: inout Car)
    func orderCar()
}


// MARK: - ЧАСТЬ #3.

// MARK: BMW

struct CarBMW: Car {
    var model: String
    var color: UIColor
    var buildDate: Date
    var price: Double
    var accessories: [AccessoriesCar]
    var isServiced: Bool
    var description: String { "Model: '\(self.model)'.Color: '\(self.color)'.isServiced: \(isServiced ? "имеется" : "отсутсвует")."}
    
    init(model: String, color: UIColor, price: Double, accessories: [AccessoriesCar], isServiced: Bool) {
        self.model = model
        self.color = color
        self.buildDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        self.price = price
        self.accessories = accessories
        self.isServiced = isServiced
    }
}

class DealershipBMW: DealershipProtocol {
    var name: String
    var showroomCapacite: UInt
    var stockCars: [Car]
    var showroomCars: [Car] = []
    var cars: [Car] = []
    var description: String { "Название салона: '\(self.name)'.\nВестимость машин: \(self.showroomCapacite).\nМашин на парковке: \(self.stockCars.count).\nМашин в салоне: \(self.showroomCars.count).\nВсего машин: \(self.cars.count).\n" }
    
    init(showroomCapacite: UInt, stockCars: [Car]) {
        self.name = "BMW"
        self.showroomCapacite = showroomCapacite
        self.stockCars = stockCars
        self.showroomCars = []
        self.cars = stockCars
    }
    
    // Метод предлагает клиенту купить доп. оборудование.
    func offerAccesories(_ accessoriesArray: [AccessoriesCar]) {
        guard !accessoriesArray.isEmpty else { return }
        print("Можно приобрести дополнительное оборудование:")
        accessoriesArray.forEach{ print($0.rawValue) }
        print("\n")
    }
    
    // Метод отправляет машину на предпродажную подготовку.
    func presaleService(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        guard !car.isServiced else { return }
        print("Выполняется предпродажная подготовка для \(car.model).")
        car.isServiced = true
        sleep(2); print("Предпродажная подготовка выполнена.\n")
    }
    
    // Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
    func addToShowroom(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        presaleService(&car)
        stockCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        showroomCars.append(car)
    }
    
    // Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка.
    func sellCar(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        guard car.isServiced else { print("Предпродажная подготовка не выполнена.\n"); return }
        guard showroomCars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) }) else { print("Данной машины: '\(car.model)' нет на парковке.\n"); return }
        
        if car.accessories.isEmpty {
            for accessory in AccessoriesCar.allCases {
                //print("Добавлен новый акссесуар: \(accessory.rawValue).")
                car.accessories.append(accessory)
            }
        }
        showroomCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        cars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        print("Машина '\(car.model)' продана.\n")
    }
    
    // Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() {
        let newCar = CarBMW(model: "BMW X5", color: .blue, price: 20, accessories: [.leatherInterior], isServiced: false)
        stockCars.append(newCar)
        cars.append(newCar)
    }
    
    // Private method's
    private func isThereDealership(car: Car) -> Bool {
        cars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) })
    }
    
    private func comparisonOfCars(lhs: Car, rhs: Car) -> Bool {
        lhs.model == rhs.model &&
        lhs.color == rhs.color &&
        lhs.buildDate == rhs.buildDate &&
        lhs.price == rhs.price
    }
}

// MARK: Mercedes

struct CarMercedes: Car {
    var model: String
    var color: UIColor
    var buildDate: Date
    var price: Double
    var accessories: [AccessoriesCar]
    var isServiced: Bool
    var description: String { "Model: '\(self.model)'.Color: '\(self.color)'.isServiced: \(isServiced ? "имеется" : "отсутсвует")."}
    
    init(model: String, color: UIColor, price: Double, accessories: [AccessoriesCar], isServiced: Bool) {
        self.model = model
        self.color = color
        self.buildDate = Date()
        self.price = price
        self.accessories = accessories
        self.isServiced = isServiced
    }
}

class DealershipMercedes: DealershipProtocol {
    var name: String
    var showroomCapacite: UInt
    var stockCars: [Car]
    var showroomCars: [Car] = []
    var cars: [Car] = []
    var description: String { "Название салона: '\(self.name)'.\nВестимость машин: \(self.showroomCapacite).\nМашин на парковке: \(self.stockCars.count).\nМашин в салоне: \(self.showroomCars.count).\nВсего машин: \(self.cars.count).\n" }
    
    init(showroomCapacite: UInt, stockCars: [Car]) {
        self.name = "Mercedes"
        self.showroomCapacite = showroomCapacite
        self.stockCars = stockCars
        self.showroomCars = []
        self.cars = stockCars
    }
    
    // Метод предлагает клиенту купить доп. оборудование.
    func offerAccesories(_ accessoriesArray: [AccessoriesCar]) {
        guard !accessoriesArray.isEmpty else { return }
        print("Можно приобрести дополнительное оборудование:")
        accessoriesArray.forEach{ print($0.rawValue) }
        print("\n")
    }
    
    // Метод отправляет машину на предпродажную подготовку.
    func presaleService(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        guard !car.isServiced else { return }
        print("Выполняется предпродажная подготовка для \(car.model).")
        car.isServiced = true
        sleep(2); print("Предпродажная подготовка выполнена.\n")
    }
    
    // Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
    func addToShowroom(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        presaleService(&car)
        stockCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        showroomCars.append(car)
    }
    
    // Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка.
    func sellCar(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        guard car.isServiced else { print("Предпродажная подготовка не выполнена.\n"); return }
        guard showroomCars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) }) else { print("Данной машины: '\(car.model)' нет на парковке.\n"); return }
        
        if car.accessories.isEmpty {
            for accessory in AccessoriesCar.allCases {
                //print("Добавлен новый акссесуар: \(accessory.rawValue).")
                car.accessories.append(accessory)
            }
        }
        showroomCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        cars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        print("Машина '\(car.model)' продана.\n")
    }
    
    // Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() {
        let newCar = CarMercedes(model: "Merccedes A", color: .blue, price: 20, accessories: [.leatherInterior], isServiced: false)
        stockCars.append(newCar)
        cars.append(newCar)
    }
    
    // Private method's
    private func isThereDealership(car: Car) -> Bool {
        cars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) })
    }
    
    private func comparisonOfCars(lhs: Car, rhs: Car) -> Bool {
        lhs.model == rhs.model &&
        lhs.color == rhs.color &&
        lhs.buildDate == rhs.buildDate &&
        lhs.price == rhs.price
    }
}

// MARK: Tesla

struct CarTesla: Car {
    var model: String
    var color: UIColor
    var buildDate: Date
    var price: Double
    var accessories: [AccessoriesCar]
    var isServiced: Bool
    var description: String { "Model: '\(self.model)'.Color: '\(self.color)'.isServiced: \(isServiced ? "имеется" : "отсутсвует")."}
    
    init(model: String, color: UIColor, price: Double, accessories: [AccessoriesCar], isServiced: Bool) {
        self.model = model
        self.color = color
        self.buildDate = Date()
        self.price = price
        self.accessories = accessories
        self.isServiced = isServiced
    }
}

class DealershipTesla: DealershipProtocol {
    var name: String
    var showroomCapacite: UInt
    var stockCars: [Car]
    var showroomCars: [Car] = []
    var cars: [Car] = []
    var description: String { "Название салона: '\(self.name)'.\nВестимость машин: \(self.showroomCapacite).\nМашин на парковке: \(self.stockCars.count).\nМашин в салоне: \(self.showroomCars.count).\nВсего машин: \(self.cars.count).\n" }
    
    init(showroomCapacite: UInt, stockCars: [Car]) {
        self.name = "Tesla"
        self.showroomCapacite = showroomCapacite
        self.stockCars = stockCars
        self.showroomCars = []
        self.cars = stockCars
    }
    
    // Метод предлагает клиенту купить доп. оборудование.
    func offerAccesories(_ accessoriesArray: [AccessoriesCar]) {
        guard !accessoriesArray.isEmpty else { return }
        print("Можно приобрести дополнительное оборудование:")
        accessoriesArray.forEach{ print($0.rawValue) }
        print("\n")
    }
    
    // Метод отправляет машину на предпродажную подготовку.
    func presaleService(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        guard !car.isServiced else { return }
        print("Выполняется предпродажная подготовка для \(car.model).")
        car.isServiced = true
        sleep(2); print("Предпродажная подготовка выполнена.\n")
    }
    
    // Метод перегоняет машину с парковки склада в автосалон, при этом выполняет предпродажную подготовку.
    func addToShowroom(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        presaleService(&car)
        stockCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        showroomCars.append(car)
    }
    
    // Метод продает машину из автосалона при этом проверяет, выполнена ли предпродажная подготовка.
    func sellCar(_ car: inout Car) {
        guard isThereDealership(car: car) else { print("Данной машины: '\(car.model)' нет в указанном салоне.\n"); return }
        guard car.isServiced else { print("Предпродажная подготовка не выполнена.\n"); return }
        guard showroomCars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) }) else { print("Данной машины: '\(car.model)' нет на парковке.\n"); return }
        
        if car.accessories.isEmpty {
            for accessory in AccessoriesCar.allCases {
                //print("Добавлен новый акссесуар: \(accessory.rawValue).")
                car.accessories.append(accessory)
            }
        }
        showroomCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        cars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        print("Машина '\(car.model)' продана.\n")
    }
    
    // Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() {
        let newCar = CarTesla(model: "Tesla Model 3", color: .blue, price: 20, accessories: [.leatherInterior], isServiced: false)
        stockCars.append(newCar)
        cars.append(newCar)
    }
    
    // Private method's
    private func isThereDealership(car: Car) -> Bool {
        cars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) })
    }
    
    private func comparisonOfCars(lhs: Car, rhs: Car) -> Bool {
        lhs.model == rhs.model &&
        lhs.color == rhs.color &&
        lhs.buildDate == rhs.buildDate &&
        lhs.price == rhs.price
    }
}






// MARK: - ЧАСТЬ #4.

protocol SpecialOffer {
    func addEmergencyPack(car: inout Car)               // Метод добавляет аптечку и огнетушитель к доп. оборудованию машины.
    func makeSpecialOffer(car: inout Car)       // Метод проверяет дату выпуска авто, если год выпуска машины меньше текущего, нужно сделать скидку 15%, а также добавить аптеку и огнетушитель.
}

extension DealershipBMW: SpecialOffer {
    func addEmergencyPack(car: inout Car) {
        car.accessories.append(.firstAidKit)
        car.accessories.append(.sunroofInCeiling)
    }
    
    func makeSpecialOffer( car: inout Car) {
        let currentYear = Calendar.current.component(.year, from: Date())
        let carBuildYear = Calendar.current.component(.year, from: car.buildDate)
        guard carBuildYear < currentYear else { return }
        car.price *= 0.85
        addEmergencyPack(car: &car)
    }
}

extension DealershipMercedes: SpecialOffer {
    func addEmergencyPack(car: inout Car) {
        car.accessories.append(.firstAidKit)
        car.accessories.append(.sunroofInCeiling)
    }
    
    func makeSpecialOffer( car: inout Car) {
        let currentYear = Calendar.current.component(.year, from: Date())
        let carBuildYear = Calendar.current.component(.year, from: car.buildDate)
        guard carBuildYear < currentYear else { return }
        car.price *= 0.85
        addEmergencyPack(car: &car)
    }
}

extension DealershipTesla: SpecialOffer {
    func addEmergencyPack(car: inout Car) {
        car.accessories.append(.firstAidKit)
        car.accessories.append(.sunroofInCeiling)
    }
    
    func makeSpecialOffer( car: inout Car) {
        let currentYear = Calendar.current.component(.year, from: Date())
        let carBuildYear = Calendar.current.component(.year, from: car.buildDate)
        guard carBuildYear < currentYear else { return }
        car.price *= 0.85
        addEmergencyPack(car: &car)
    }
}


// MARK: - ПРОВЕРКИ.

/*  Создайте массив, положите в него созданные дилерские центры.
    Пройдитесь по нему циклом и выведите в консоль слоган для каждого дилеского центра (слоган можно загуглить).*/

var bmwFirst: Car = CarBMW(model: "BMW X5", color: .black, price: 50, accessories: [], isServiced: false)
var bmwSecond: Car = CarBMW(model: "BMW X6", color: .white, price: 60, accessories: [], isServiced: true)
var bmwThird: Car = CarBMW(model: "BMW X7", color: .red, price: 100, accessories: [.sportsWheels, .tinting], isServiced: false)

var delBMW = DealershipBMW(showroomCapacite: 8, stockCars: [ bmwFirst, bmwSecond, bmwThird ])
var delMercedes = DealershipMercedes(showroomCapacite: 10, stockCars: [])
var delTesla = DealershipTesla(showroomCapacite: 15, stockCars: [])


func brandSlogan(dealership: String) {
    switch dealership {
    case "BMW":
        print("BMW: С удовольствием за рулем")
    case "Mercedes":
        print("Mecedes: Лучшее или ничего")
    case "Tesla":
        print("Tesla: Жги резину, а не бензин")
    default:
        print("Для \(dealership) слоган не найден")
    }
}
var dealerships: [DealershipProtocol] = [delBMW, delMercedes, delTesla]
dealerships.forEach{ brandSlogan(dealership: $0.name) }


print(delBMW.description)
delBMW.offerAccesories([.tinting, .sportsWheels, .alarmSystem])
bmwFirst.isServiced
delBMW.presaleService(&bmwThird)
delBMW.presaleService(&bmwFirst)
bmwFirst.isServiced
delBMW.addToShowroom(&bmwFirst)
delBMW.sellCar(&bmwFirst)
delBMW.orderCar()
delBMW.orderCar()
delBMW.orderCar()
print(delBMW.description)

bmwThird.price
bmwThird.accessories
delBMW.makeSpecialOffer(car: &bmwThird)
bmwThird.price
bmwThird.accessories
