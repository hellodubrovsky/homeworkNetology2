/*  MARK: - Задача #1.

    Возьмите любой пример из жизни (класс) и опишите уровни доступа к нему.
    Постарайтесь описать как публичные,, так и закрытые уровни и методы.
    Для решения задачи можно взять класс из предыдущего домашнего задания.
    
    1) Пример:
        Класс: такси
        Имеет публичный доступ, так как любой может воспользоваться отдельным экземпляром (объектом) такси.
        Пример геттера: узнать цену поездки
        Пример сеттера: установить конечную точку маршрута
        Пример публичного метода: заказать такси к определенному месту
        Пример приватного метода: доехать до клиента

    2) Допуск:
        В качестве примеров не используйте телевизор и пульт, так как это будет входить в следующие домашние задания.
        Постарайтесь описать, почему вы определили тот или иной уровень доступа.
 
    
 
    MARK: РЕШЕНИЕ:
    Класс: Сессии приложения по отправке сообщений.
    Геттер: Статус подключения.
    Геттер: Сообщения от собеседника.
    Сеттер: Никнейм пользователя.
    Публичный метод: Авторизация в приложения.
    Приватный метод: Загрузка сообщений собеседника.
 
    P.S. Пример является абстрактным, но кмк выполняет условия данного задания. */


protocol MessageSessionProtocol {
    var statusConnection: Bool { get }                                        // [Геттер] Статус подключения - свойство которое можно только получить.
    var interlocutorsMessages: [Int: String]? { get }                         // [Геттер] Сообщения от собеседника - можно только получить.
    var nameUser: String { get set }                                          // [Сеттер] Имя юзера - можно получить, а также изменить.
}

class MessagesSession: MessageSessionProtocol {
    var statusConnection: Bool = false
    var interlocutorsMessages: [Int: String]? = nil
    var nameUser: String
    
    private(set) var userLogin: String                                        // Приватное св-во логин, которое можно только посмотреть из вне.
    private var userPassword: String                                          // Приватное св-во пароль, которое нельзя изменить из вне.
    
    init(nUser: String, userLogin: String, userPassword: String) {
        self.nameUser = nUser
        self.userLogin = userLogin
        self.userPassword = userPassword
    }
    
    // MARK: Public's methods
    func connection(login: String, password: String) -> Bool {                // Публичный метод - Авторизация в приложения.
        if login == self.userLogin && password == self.userPassword {
            self.statusConnection = true
            uploadingMessages()
            return true
        } else {
            self.statusConnection = false
            return false
        }
    }
    
    // MARK: Private method
    private func uploadingMessages() -> [Int: String] {                       // Приватный метод - Загрузка сообщений собеседника.
        return [1: "Привет", 2: "Как дела?"]
    }
}













/*  MARK: - Задача #2.

    Создайте класс.
    Создайте 3 метода с одинаковым названием, но разными сигнатурами.
    Статический анализатор Swift подскажет вам, если overload не получится ;) */


class Messages {
    func sendMessage() -> Double {
        return 3.14
    }
    
    func sendMessage(input: String) -> String {
        return "Message String: \(input)"
    }
    
    func sendMessage(input: Int) -> String {
        return "Message Integer: \(input)"
    }
}













/*  MARK: - Задача #3.

    Создайте класс-родитель. Определите в нем метод.
    Создайте класс-наследник. Переопределите в нем метод родителя, но с вызовом родительского метода.*/

class Phone {
    func makeCall(to number: String) {
        print("\nПроисходит аудио-вызов на номер: \(number).")
    }
}

class Smartphone: Phone {
    var online: Bool = true
    override func makeCall(to number: String) {
        super.makeCall(to: number)
        online ? print("Вызов происходит через интернет-соединение. Деньги не списываются.") : print("Вызов происходит через SIM. Интернет не активен в данный момент.")
    }
}

var phone = Phone()
var iPhone = Smartphone()

phone.makeCall(to: "111-35-35")
iPhone.makeCall(to: "555-35-35")
