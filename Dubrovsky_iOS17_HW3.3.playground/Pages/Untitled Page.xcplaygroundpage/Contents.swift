import UIKit
import Foundation

/* HW: https://github.com/netology-code/aios-homeworks/blob/master/3.3_homework.md */



enum AccessoriesCar: String, CaseIterable {
    case tuning = "Тюнинг"
    case alarmSystem = "Сигнализация"
    case sportsWheels = "Спортивные колеса"
    case sunroofInCeiling = "Панорамная крыша"
    case fireExtinguisher = "Огнетушитель"
    case firstAidKit = "Аптечка"
}



// MARK: - ЧАСТЬ #1. PROTOCOL "CAR"

protocol Car {
    var model: String {get}
    var color: UIColor {get}
    var buildDate: Date {get}
    var price: Double {get set}
    var accessories: [AccessoriesCar] {get set}
    var isServiced: Bool {get set}
}



// MARK: - ЧАСТЬ #2. PROTOCOL "DEALERSHIP"

protocol Dealership {
    var name: String {get}
    var showroomCapacite: UInt {get}
    var stockCars: [Car] {get set}
    var showroomCars: [Car] {get set}
    var cars: [Car] {get set}
    
    // Method's
    func offerAccesories(_: [AccessoriesCar])
    func presaleService(_: inout Car)
    func addToShowroom(_: inout Car)
    func sellCar(_: inout Car)
    func orderCar()
}



// MARK: - ЧАСТЬ #3. STRUCT "CarBMW"

struct CarBMW: Car {
    var model: String
    var color: UIColor
    var buildDate: Date
    var price: Double
    var accessories: [AccessoriesCar]
    var isServiced: Bool
    var description: String { "Model: '\(self.model)'.\nColor: '\(self.color)'.\nisServiced: \(isServiced ? "имеется" : "отсутсвует").\n"}
    
    init(model: String, color: UIColor, price: Double, accessories: [AccessoriesCar], isServiced: Bool, buildDate: Date) {
        self.model = model
        self.color = color
        self.buildDate = buildDate
        self.price = price
        self.accessories = accessories
        self.isServiced = isServiced
    }
}

// MARK: CLASS "DealershipBMW"

class DealershipBMW: Dealership {
    var name: String
    var showroomCapacite: UInt
    var stockCars: [Car]
    var showroomCars: [Car]
    var cars: [Car]
    var description: String { "Название салона: '\(self.name)'.\nВестимость машин: \(self.showroomCapacite).\nМашин на парковке: \(self.stockCars.count).\nМашин в салоне: \(self.showroomCars.count).\nВсего машин: \(self.cars.count).\n" }
    
    init(showroomCapacite: UInt) {
        self.name = "BMW"
        self.showroomCapacite = showroomCapacite
        self.stockCars = []
        self.showroomCars = []
        self.cars = []
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
                car.accessories.append(accessory)
            }
        }
        showroomCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        cars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
        print("Машина '\(car.model)' продана.\n")
    }
    
    // Метод делает заказ новой машины с завода, т.е. добавляет машину на парковку склада.
    func orderCar() {
        guard showroomCapacite > cars.count else { return }
        var newCar = CarBMW(model: "BMW X5", color: .blue, price: 20, accessories: [.sunroofInCeiling], isServiced: false, buildDate: Date())
        newCar.buildDate = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        stockCars.append(newCar)
        cars.append(newCar)
    }
    
    // Кастомный метод, который добавляет конкретный автомобиль
    func addingNew(to car: Car) {
        guard showroomCapacite > cars.count else { return }
        stockCars.append(car)
        cars.append(car)
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



// MARK: - ЧАСТЬ #4. PROTOCOL "SpecialOffer"

enum DealershipError: Error {
    case thePromotionIsNotSuitable
}

protocol SpecialOffer {
    func addEmergencyPack(car: inout Car) throws
    func makeSpecialOffer(car: inout Car) throws
}

extension DealershipBMW: SpecialOffer {
    // Добавления к списку аксессуаров аптечки и огнетушителя
    func addEmergencyPack(car: inout Car) {
        car.accessories.append(.firstAidKit)
        car.accessories.append(.sunroofInCeiling)
    }
    
    // Если конкретная машина прошлогодняя, снижаем цену на 15% и добавляем аптечку и огнетушитель
    func makeSpecialOffer(car: inout Car) throws {
        let currentYear = Calendar.current.component(.year, from: Date())
        let carBuildYear = Calendar.current.component(.year, from: car.buildDate)
        guard carBuildYear < currentYear else { throw DealershipError.thePromotionIsNotSuitable }
        car.price *= 0.85
        addEmergencyPack(car: &car)
        print("Машина: \(car.model), изменена под акцию. Новая цена: \(car.price), Новые аксессуары: \(car.accessories).")
    }
    
    // Проверяем список машин в салоне и на парковке, если есть прошлогодние, снижаем цену на 15% и добавляем аптечку и огнетушитель.
    // Если есть машины на складе со скидкой, они перегоняются в салон.
    func makeSpecialOfferCars() throws {
        let currentYear = Calendar.current.component(.year, from: Date())
        for car in cars {
            let carBuildYear = Calendar.current.component(.year, from: car.buildDate)
            if carBuildYear < currentYear {
                var updateCar = car
                updateCar.price *= 0.85
                addEmergencyPack(car: &updateCar)
                if showroomCars.contains(where: { return comparisonOfCars(lhs: $0, rhs: car) }) {
                    showroomCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
                    showroomCars.append(updateCar)
                    cars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
                    cars.append(updateCar)
                    print("Машина \(updateCar.model) подошла под акцию. Новая цена: \(updateCar.price). Машина осталась в автосалоне.")
                } else {
                    stockCars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
                    showroomCars.append(updateCar)
                    cars.removeAll(where: { return comparisonOfCars(lhs: $0, rhs: car) } )
                    cars.append(updateCar)
                    print("Машина \(updateCar.model) подошла под акцию. Новая цена: \(updateCar.price). Машина переместилась из парковки в автосалон.")
                }
            } else {
                print("Машина \(car.model) НЕ подошла под акцию. Цена осталась: \(car.price). Сейчас будет ошибка.")
                // Сюда прилетают машины, которые не подошли под акцию.
                throw DealershipError.thePromotionIsNotSuitable
            }
        }
    }
}



// MARK: - ПРОВЕРКИ.

var firstBmw: Car = CarBMW(model: "BMW X8", color: .white, price: 20_000_000, accessories: [], isServiced: false, buildDate: Calendar.current.date(byAdding: .year, value: -1, to: Date())!)
var secondBmw: Car = CarBMW(model: "BMW X8", color: .white, price: 20_000_000, accessories: [], isServiced: false, buildDate: Date())
var dealer = DealershipBMW(showroomCapacite: 4)

dealer.addingNew(to: firstBmw)


dealer.orderCar()
dealer.orderCar()

try? dealer.makeSpecialOffer(car: &firstBmw)
try? dealer.makeSpecialOfferCars()

print("\n")

dealer.addingNew(to: secondBmw)
try? dealer.makeSpecialOffer(car: &secondBmw)
try? dealer.makeSpecialOfferCars()
