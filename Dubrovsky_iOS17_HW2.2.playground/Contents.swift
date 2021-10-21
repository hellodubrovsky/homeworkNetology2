import Foundation


//  MARK: - Задача #1.
/*  Вы разрабатываете библиотеку аудиотреков. Вам необходимо реализовать одну из категорий музыки, наполненную треками.
    Алгоритм выполнения:
    - Создайте объект трек.
    - Определите в нем свойства имя, исполнитель, длительность и страна.
    - Создайте класс категория.
    - Объявите в нем свойства название категории, список треков и количество треков в списке (экспериментируйте с "ленивыми" и вычисляемыми свойствами).
    - Определите методы добавления и удаления треков в эту категорию.*/


class Track {
    private let artist: String
    private let nameSong: String
    private let country: String
    private let duration: String
    var fullDescriptionSong: String { "Artist: \(artist), Name: \(nameSong), Country: \(country), Duration: \(duration)." }
    
    init(artist: String, nameSong: String, country: String, duration: String) {
        self.artist = artist
        self.nameSong = nameSong
        self.country = country
        self.duration = duration
    }
}

var one = Track(artist: "A", nameSong: "B", country: "C", duration: "D")
print(one.fullDescriptionSong)















//  MARK: - Задача #2.
/*  Доработайте свою библиотеку так, чтобы в ней было несколько категорий.
    Алгоритм выполнения: Создайте класс библиотеки. Этот класс будет аналогичен классу категории, только хранить он должен список категорий.*/

















//  MARK: - Задача #3.
//  Преобразуйте классы так, чтобы в пределах вашей библиотеки можно было обмениваться треками между категориями.






























class Tracker {
    private var timer: Timer?
    var interval: TimeInterval? {
        willSet {
            if let _ = interval { print("Timer will be started with interval: \(interval).") }
            guard let _ = timer else { return }
            print("Timer stopped.")
            timer?.invalidate()
            timer = nil
        }
        didSet {
            if let _ = oldValue {
                print("Old interval was: \(oldValue).")
            } else {
                print("No interval beforeL: \(oldValue).")
            }
            
            guard let newInterval = interval else { return }
            timer = Timer.scheduledTimer(withTimeInterval: newInterval,
                                         repeats: true,
                                         block: { _ in print("Do  will be started with interval: \(newInterval).")} )
        }
    }
}


let tracker = Tracker()
tracker.interval = 3
tracker.interval = 4

DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    tracker.interval = 2
}

































