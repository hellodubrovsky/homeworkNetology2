//import Foundation

import Darwin


//  MARK: - Задача #1.
/*  Вы разрабатываете библиотеку аудиотреков. Вам необходимо реализовать одну из категорий музыки, наполненную треками.
    Алгоритм выполнения:
    - Создайте объект трек.
    - Определите в нем свойства имя, исполнитель, длительность и страна.
    - Создайте класс категория.
    - Объявите в нем свойства название категории, список треков и количество треков в списке (экспериментируйте с "ленивыми" и вычисляемыми свойствами).
    - Определите методы добавления и удаления треков в эту категорию.*/


class Track {
    let artist: String
    let titleSong: String
    let country: String
    let duration: Double
    var fullDescriptionSong: String { "- Title: '\(titleSong)', artist: '\(artist)', country: '\(country)', duration: '\(duration)'." }
    
    init(artist: String, nameSong: String, country: String, duration: Double) {
        self.artist = artist
        self.titleSong = nameSong
        self.country = country
        self.duration = duration
    }
}

class Category {
    private(set) var nameCategory: String
    private(set) lazy var countTrack: UInt = UInt(trackList.count)
    private(set) var trackList: [String: [String]] { willSet { self.countTrack = UInt(newValue.count) }}
    var fullDescriptionCategory: String { "\nDescription Category: name: '\(nameCategory)', countTracks: '\(countTrack)', track(s): \(informationAboutAllTracks())" }
    
    init(nameCategory: String) {
        self.nameCategory = nameCategory
        self.trackList = Dictionary<String, [String]>()
    }
    
    func adding(song: Track) {
        guard trackList[song.titleSong] == nil else { print("\nThe song '\(song.titleSong)' already exists."); return }
        trackList[song.titleSong] = [song.artist, song.country, String(song.duration)]
        print("\nAdded a new song: \(song.fullDescriptionSong)")
    }
    
    func removingSongBy(name: String) {
        guard trackList[name] != nil else { print("\nThere is no such song '\(name)' in the category."); return }
        trackList.removeValue(forKey: name)
    }
    
    // Private method's
    private func informationAboutAllTracks() -> String {
        guard !trackList.isEmpty else {return "empty."}
        var info: String = ""
        trackList.forEach{ info += "\n- Title: \($0.key), artist: \($0.value[0]), country: \($0.value[1]), duration: \($0.value[1])." }
        return info
    }
}













































//  MARK: - Задача #2.
/*  Доработайте свою библиотеку так, чтобы в ней было несколько категорий.
    Алгоритм выполнения: Создайте класс библиотеки. Этот класс будет аналогичен классу категории, только хранить он должен список категорий.*/

















//  MARK: - Задача #3.
//  Преобразуйте классы так, чтобы в пределах вашей библиотеки можно было обмениваться треками между категориями.






























//class Tracker {
//    private var timer: Timer?
//    var interval: TimeInterval? {
//        willSet {
//            if let _ = interval { print("Timer will be started with interval: \(interval).") }
//            guard let _ = timer else { return }
//            print("Timer stopped.")
//            timer?.invalidate()
//            timer = nil
//        }
//        didSet {
//            if let _ = oldValue {
//                print("Old interval was: \(oldValue).")
//            } else {
//                print("No interval beforeL: \(oldValue).")
//            }
//
//            guard let newInterval = interval else { return }
//            timer = Timer.scheduledTimer(withTimeInterval: newInterval,
//                                         repeats: true,
//                                         block: { _ in print("Do  will be started with interval: \(newInterval).")} )
//        }
//    }
//}
//
//
//let tracker = Tracker()
//tracker.interval = 3
//tracker.interval = 4
//
//DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
//    tracker.interval = 2
//}

































