// MARK: - Задача #1.

/*  Представьте себя инженером проектировщиком телевизоров во времена, когда эпоха телевещания только набирала обороты.
    Вам поступила задача создать устройство для просмотра эфира в домашних условиях "Телевизор в каждую семью".
    Вам нужно реализовать перечисление "Телевизионный канал" с 5-7 каналами.

    Алгоритм выполнения:
    1) Реализуйте класс "Телевизор". У него должны быть состояния:
       - Фирма/модель (реализовать одним полем);
       - Включен/выключен; текущий телеканал;
    2) У него должно быть поведение: показать, что сейчас по телеку.
    3) Вызовите метод и покажите, что сейчас по телеку.
    4) Сделайте изменение состояний телевизора (на свой выбор).
    5) Повторите вызов метода и покажите, что сейчас по телеку. */


enum Channels: String {
    case one = "Первый"
    case two = "Россия 1"
    case three = "Матч ТВ"
    case four = "НТВ"
    case five = "Пятый"
    case six = "Disney"
}

class TV {
    let brand: String
    private(set) var switcher: Bool
    private(set) var currentChannel: Channels
    
    init(brand: String, switcher: Bool, currentChannel: Channels) {
        self.brand = brand
        self.switcher = switcher
        self.currentChannel = currentChannel
    }
    
    // Включение/Выключение телевизора.
    func changeSwitch() {
        self.switcher = self.switcher ? false : true
    }
    
    // Изменение канала.
    func changeCurrentChannel(to newChannel: Channels) {
        guard self.switcher else { print("ТВ выключен"); return }
        self.currentChannel = newChannel
        print("Переключение на канал: '\(self.currentChannel.rawValue)'.")
    }
    
    // Показать, какой канал сейчас играет
    func showCurrentChannel() {
        guard self.switcher else { print("ТВ выключен"); return }
        print("В данный момент играет канал: '\(self.currentChannel.rawValue)'.")
    }
}

var samsung = TV(brand: "Samsung T-800", switcher: false, currentChannel: .one)
samsung.changeSwitch()
samsung.showCurrentChannel()
samsung.changeCurrentChannel(to: .six)










// MARK: - Задача #2.

/*  Время идет, рынок и потребители развиваются, и ваша компания набирает ритм.
    Поступают все новые и новые требования к эволюции устройств. Перед вами снова инженерная задача — обеспечить пользователей практичным устройством.

    Алгоритм выполнения:
    1) Создайте новый класс Телевизор (с другим названием класса), который будет уметь все, что и предыдущий.
    2) Реализуйте структуру настроек:
       - Громкость от 0 до 1 (подумайте, какой тип использовать);
       - Показывать цветом или черно-белым (подумайте, какой тип данных лучше всего использовать).
    3) Интегрируйте Настройки в новый класс Телевизор.
    4) Вызовите метод и покажите, что сейчас идет по телевизору, учитывая настройки.*/


enum ResolutionTV: String {
    case r16x9 = "16x9"
    case r4x3 = "4x3"
}

class PlasmaTV: TV {
    private(set) var volume: Int = 0
    private(set) var resolution: ResolutionTV
    
    init(brand: String, switcher: Bool, currentChannel: Channels, volume: Int, resolution: ResolutionTV) {
        self.volume = volume
        self.resolution = resolution
        super.init(brand: brand, switcher: switcher, currentChannel: currentChannel)
    }
    
    // Изменении громкости
    func changeVolume(louder: Bool) {
        guard self.switcher else { print("ТВ выключен"); return }
        if louder {
            guard (self.volume + 1) <= 10 else { print("Максимальная громкость"); return }
            self.volume += 1
            print("Громкость повышена до \(self.volume).")
        } else {
            guard (self.volume - 1) >= 0 else { print("Минимальная громкость"); return }
            self.volume -= 1
            print("Громкость понижена до \(self.volume).")
        }
    }
    
    // Изменении разрешения
    func changeResolution(to newResolution: ResolutionTV) {
        guard self.switcher else { print("ТВ выключен"); return }
        self.resolution = newResolution
        print("Разрешение телевизора изменено на: \(self.resolution.rawValue).")
    }
    
    // Измененный метод переключения канала, с отображением найтроек.
    override func changeCurrentChannel(to newChannel: Channels) {
        super.changeCurrentChannel(to: newChannel)
        printInfoAboutSettings()
    }
    
    // Измененный метод, просмотра текущего канала, с отображением найтроек.
    override func showCurrentChannel() {
        super.showCurrentChannel()
        printInfoAboutSettings()
    }
    
    // Private method
    func printInfoAboutSettings() {
        print("Воспроизведение происходит на громкости: \(self.volume) и на разрешении: \(self.resolution.rawValue).")
    }
}

var lg = PlasmaTV(brand: "LG", switcher: true, currentChannel: .four, volume: 1, resolution: .r16x9)
lg.showCurrentChannel()










// MARK: - Задача #3.

/*  Порог новой эры пройден. Теперь не только есть радиоволна, но и видеомагнитофоны.
    Эту технику подключают проводами к телевизору и смотрят в записи свои любимые фильмы.
    Вам, как ведущему инженеру, срочно нужно адаптировать продукт вашей компании, потому как спрос на устаревший вариант резко пошел вниз.

    Алгоритм выполнения
    1) Создайте перечисление со связанными значениями с двумя кейсами: телеканал и подключение по входящему видео порту;
    2) Интегрируйте эту опцию в Телевизор.
    3) Вызовите метод и покажите, что сейчас по телевизору. */
