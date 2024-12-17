import Foundation

class LocalizationHelper {

    // Получение локализованной строки для кнопки входа
    static func loginButtonTitle() -> String {
        return NSLocalizedString("login_button_title", tableName: nil, comment: "Title for the login button")
    }

    // Получение локализованного приветственного сообщения с именем пользователя
    static func welcomeMessage(username: String) -> String {
        return String(format: NSLocalizedString("welcome_message", tableName: nil, comment: "Welcome message for the user"), username)
    }

    // Локализованное название для заголовка "Просмотры"
    static func viewsTitle() -> String {
        return NSLocalizedString("views_title", tableName: nil, comment: "Title for views section")
    }

    // Локализованное название для заголовка "Фотографии"
    static func photosTitle() -> String {
        return NSLocalizedString("photos_title", tableName: nil, comment: "Title for photos section")
    }

    // Локализованное название для заголовка "Сменить пароль"
    static func changePasswordTitle() -> String {
        return NSLocalizedString("change_password", tableName: nil, comment: "Title for change password option")
    }
}
