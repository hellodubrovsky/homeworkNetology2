import UIKit
import Foundation



//   MARK: - Задача #1.
/*   Вы продолжаете разрабатывать библиотеку аудио треков. Сейчас будем работать над исполнителями треков.
     Алгоритм выполнения:
     1) Создайте суперкласс артист;
     2) Определите в нем общие для артиста свойства (имя, страна, жанр);
     3) Определите общие методы (написать трек и исполнить трек);
     4) В реализацию метода "написать трек" добавьте вывод в консоль "Я (имя артиста) написал трек (название трека)";
     5) В реализацию метода "исполнить трек" добавьте вывод в консоль "Я (имя артиста) исполнил трек (название трека)";
     6) Создайте 3 сабкласса любых артистов и переопределите в них свойства суперкласса класса.
 
     MARK: Задача #2.
     Создание списка артистов.
     Алгоритм выполнения:
     1) Доработайте существующих артистов так, чтобы они имели уникальные для каждого из них свойства и методы.
     2) Защитите этих артистов от редактирования в будущем. */



// MARK: BaseClass.

class Artist {
    private(set) var name: String
    private(set) var country: String
    private(set) var genre: String
    
    init(name: String, country: String, genre: String) {
        self.name = name
        self.country = country
        self.genre = genre
    }
    
    func writeTrack(withTheTitle track: String) {
        print("I \(self.name) wrote a track '\(track)'.")
    }
    
    func singTrack(byName track: String) {
        print("I \(self.name) sang the track to '\(track)'.")
    }
}



// MARK: Sub Classes.

final class PianoPlayer: Artist {
    
    private(set) var presenceOfPiano: Bool
    private(set) var presenceOfNotes: Bool
    
    init(name: String, country: String, genre: String, presenceOfPiano: Bool, presenceOfNotes: Bool) {
        self.presenceOfPiano = presenceOfPiano
        self.presenceOfNotes = presenceOfNotes
        super.init(name: name, country: country, genre: genre)
    }

    func buyPiano() {
        guard !presenceOfPiano else { return }
        presenceOfPiano = true
    }
    
    override func writeTrack(withTheTitle track: String) {
        guard presenceOfNotes else { print("No piano."); return}
        super.writeTrack(withTheTitle: track)
        print("And pick up the notes to the text.")
    }
    
    override func singTrack(byName track: String) {
        guard presenceOfNotes else { print("No piano."); return}
        super.singTrack(byName: track)
        print("And performed on the piano.")
    }
}

final class GitarPlayer: Artist {
    
    private(set) var presenceOfStrings: Bool
    
    init(name: String, country: String, genre: String, presenceOfStrings: Bool) {
        self.presenceOfStrings = presenceOfStrings
        super.init(name: name, country: country, genre: genre)
    }
    
    func guitarTuning() {
        guard !presenceOfStrings else { return }
        presenceOfStrings = true
    }
    
    override func writeTrack(withTheTitle track: String) {
        guard presenceOfStrings else { print("The guitar is not tuned."); return}
        super.writeTrack(withTheTitle: track)
        print("And pick up the chords.")
    }
    
    override func singTrack(byName track: String) {
        guard presenceOfStrings else { print("The guitar is not tuned."); return}
        super.singTrack(byName: track)
        print("And play the melody on the guitar.")
    }
}

final class Bitmaker: Artist {
    
    private(set) var storedBits: [String] = []
    
    func viewAllBits() {
        guard !storedBits.isEmpty else { return }
        print("All stored bits:")
        storedBits.forEach{ print($0)}
    }
    
    override func writeTrack(withTheTitle track: String) {
        super.writeTrack(withTheTitle: track)
        print("And pick up the bits.")
        storedBits.append(track)
    }
    
    override func singTrack(byName track: String) {
        super.singTrack(byName: track)
        print("And play a beat symphony.")
    }
}


 
 
 
 
 
 
 
 
 
 
//  MARK: - Задача #3.
/*  1) Создайте пустой массив, чтобы потом добавить в него ваших артистов;
    2) Добавьте созданных ранее артистов в массив;
    3) Напишите отчет о том, что вы поняли/в чем разобрались, выполняя это задание;
    4) Дайте оценку своему пониманию данной темы.
    
    Данное задание поможет вам лучше понять эту тему.
    В процессе написания отчета вы выявите слабые и сильные места в изучении данной темы, закроете пробелы или у вас появятся новые вопросы.
    При возникновении вопросов можете писать в чат группы, либо в лс преподавателю в Slack. */

var artist = Artist(name: "Garfild", country: "Russia", genre: "Jazz")
var artistPiano = PianoPlayer(name: "Andrew", country: "England", genre: "Rock", presenceOfPiano: true, presenceOfNotes: true)
var artistGitar = GitarPlayer(name: "Tommy", country: "USA", genre: "Rock", presenceOfStrings: true)
var bitmaker = Bitmaker(name: "Anna", country: "Ukraine", genre: "Pop")

var arrayArtist: [Artist] = []
arrayArtist.append(artist)
arrayArtist.append(artistPiano)
arrayArtist.append(artistGitar)
arrayArtist.append(bitmaker)


/*  MARK: Краткий отчёт
    В принципе, тема показалась достаточно легкой. Наследование классная штука, особенно понравилось, что можно объединять различные классы-родсвенники одним типом.
    Как это реализовано в массиве артистов выше. Оцениваю своё понимание на 9/10.
 */
