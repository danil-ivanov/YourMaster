

///Протокол для взаимодействия с интерактором для авторизации
protocol LoginInteractorInput {

    ///метод, который инициирует отправку смс-кода
    /// - Parameter phone: - номер телефона, куда придет смс-код
    func login(with phone: String)

    ///метод, проверяющий смс-код
    /// - Parameter code: - смс-код
    /// - Parameter phone: - номер телефона
    func sendVerficationCode(code: String, phone: String)
}
