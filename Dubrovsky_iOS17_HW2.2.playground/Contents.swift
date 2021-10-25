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

class Song {
    let artist: String
    let titleSong: String
    let country: String
    let duration: Double
    var fullDescriptionSong: String { "- 🎸Title: '\(titleSong)', artist: '\(artist)', country: '\(country)', duration: '\(duration)'." }
    
    init(nameSong: String, artist: String, country: String, duration: Double) {
        self.titleSong = nameSong
        self.artist = artist
        self.country = country
        self.duration = duration
    }
}



class CategoryMusic {
    private(set) var nameCategory: String
    private(set) lazy var countTrack: UInt = UInt(trackList.count)
    private(set) var trackList: [String: Song] { willSet { self.countTrack = UInt(newValue.count) }}
    var fullDescriptionCategory: String { "\n📟 Description Category: name: '\(nameCategory)', countTracks: '\(countTrack)', track(s): \(informationAboutAllTracks())" }
    
    init(nameCategory: String) {
        self.nameCategory = nameCategory
        self.trackList = Dictionary<String, Song>()
    }
    
    // Метод добавления новой песни.
    func adding(song: Song) {
        guard trackList[song.titleSong] == nil else { print("\n📍The song '\(song.titleSong)' already exists."); return }
        trackList[song.titleSong] = song
    }
    
    // Метод удаления существующей песни.
    func removingSongBy(name: String) {
        guard trackList[name] != nil else { print("\n📍There is no such song '\(name)' in the category."); return }
        trackList.removeValue(forKey: name)
    }

    // Метод вывода информация об песнях. Используется в fullDescriptionCategory.
    private func informationAboutAllTracks() -> String {
        guard !trackList.isEmpty else {return "empty."}
        var info: String = ""
        trackList.forEach{ info += "\n\($0.value.fullDescriptionSong)" }
        return info
    }
}






//  MARK: - Задача #2.
/*  Доработайте свою библиотеку так, чтобы в ней было несколько категорий.
    Алгоритм выполнения: Создайте класс библиотеки. Этот класс будет аналогичен классу категории, только хранить он должен список категорий.*/

class Library {
    private(set) var library: [String: CategoryMusic] = [:]
    var fullDescriptionLibrary: String { "\n📲 Description library, category's: \(informationAboutAllCategory())" }
    
    // Добавление новой категории.
    func adding(category: CategoryMusic) {
        guard library[category.nameCategory] == nil else { print("\n📍The category '\(category.nameCategory)' already exists."); return }
        library[category.nameCategory] = category
        //print("\nIn libraby added a new category: \(category.fullDescriptionCategory)")
    }
    
    // Удаление существующей категории.
    func removingCategoryBy(name: String) {
        guard library[name] != nil else { print("\n📍There is no such category '\(name)' in the library."); return }
        library.removeValue(forKey: name)
    }

    // Метод вывода информация об категориях. Используется в fullDescriptionLibrary.
    private func informationAboutAllCategory() -> String {
        var info: String = ""
        library.forEach{ info += "\n\($0.value.fullDescriptionCategory)"}
        return info
    }
}






//  MARK: - Задача #3.
//  Преобразуйте классы так, чтобы в пределах вашей библиотеки можно было обмениваться треками между категориями.

extension Library {
    
    // Метод перемещения треков между категориями.
    func moving(song: Song, from sentCategory: CategoryMusic, to receivedCategory: CategoryMusic) {
        guard checksForMovingSongs(song: song, sentCategory: sentCategory, receivedCategory: receivedCategory) else { return }
        library[sentCategory.nameCategory]!.removingSongBy(name: song.titleSong)
        library[receivedCategory.nameCategory]!.adding(song: song)
    }
    
    // Проверки, необходимые для метода перемещения треков между категориями.
    private func checksForMovingSongs(song: Song, sentCategory: CategoryMusic, receivedCategory: CategoryMusic) -> Bool {
        guard library[sentCategory.nameCategory] != nil else { print("\n📍Category '\(sentCategory.nameCategory)' is not in your library. You can add using the adding method."); return false }
        guard library[receivedCategory.nameCategory] != nil else { print("\n📍Category '\(receivedCategory.nameCategory)' is not in your library. You can add using the adding method."); return false }
        guard sentCategory.trackList[song.titleSong] != nil else { print("\n📍There is no specified song in category '\(sentCategory.nameCategory)'."); return false }
        guard receivedCategory.trackList[song.titleSong] == nil else { print("\n📍The specified song already exists in the '\(receivedCategory.nameCategory)' category."); return false }
        return true
    }
}





// MARK: - Примеры.
var song_1 = Song(nameSong: "Hello", artist: "Bittles", country: "Englang", duration: 3.54)
var song_2 = Song(nameSong: "Beatiful", artist: "AC/CD", country: "USA", duration: 5.21)
var song_3 = Song(nameSong: "Wonderful", artist: "Dippurple", country: "Australia", duration: 2.97)
var song_4 = Song(nameSong: "Good Bye!", artist: "Eminem", country: "USA", duration: 4.21)
var song_5 = Song(nameSong: "Rich", artist: "Drake", country: "Germany", duration: 3.66)
var song_6 = Song(nameSong: "Jacke", artist: "Morgen", country: "Russia", duration: 5.55)

var rock = CategoryMusic(nameCategory: "Rock")
var jazz = CategoryMusic(nameCategory: "Jazz")
var rap = CategoryMusic(nameCategory: "Rap")

rock.adding(song: song_1)
rock.adding(song: song_2)
jazz.adding(song: song_3)
rap.adding(song: song_4)
rap.adding(song: song_5)
rap.removingSongBy(name: "Good Bye!")

print(rock.fullDescriptionCategory)
print(jazz.fullDescriptionCategory)
print(rap.fullDescriptionCategory)

var lib = Library()
lib.adding(category: rock)
lib.adding(category: jazz)
lib.adding(category: rap)
lib.removingCategoryBy(name: "Jazz")

rock.adding(song: song_6)
rap.adding(song: song_6)
rap.adding(song: song_4)
rap.removingSongBy(name: "Good Bye!")

print(lib.fullDescriptionLibrary)

lib.moving(song: song_1, from: jazz, to: rap)
lib.moving(song: song_1, from: rap, to: jazz)
lib.moving(song: song_5, from: rock, to: rap)
lib.moving(song: song_6, from: rap, to: rock)

lib.moving(song: song_1, from: rock, to: rap)
lib.moving(song: song_2, from: rock, to: rap)

print(lib.fullDescriptionLibrary)
