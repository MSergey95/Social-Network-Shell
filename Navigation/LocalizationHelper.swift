import Foundation

class LocalizationHelper {

    // Получение локализованной строки для кнопки входа
    static func loginButtonTitle() -> String {
        return NSLocalizedString("login_button_title", comment: "Title for the login button")
    }

    // Получение локализованного приветственного сообщения с именем пользователя
    static func welcomeMessage(username: String) -> String {
        return String(format: NSLocalizedString("welcome_message", comment: "Welcome message for the user"), username)
    }

    // Получение локализованной строки для количества лайков с учетом множественных форм
    static func likesCountText(count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("like_count", comment: "Likes count"), count)
    }

    // Получение локализованной строки для количества просмотров с учетом множественных форм
    static func viewsCountText(count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("views_count", comment: "Views count"), count)
    }

    // Локализованное название для заголовка "Просмотры"
    static func viewsTitle() -> String {
        return NSLocalizedString("views_title", comment: "Title for views section")
    }

    // Локализованное название для заголовка "Фотографии"
    static func photosTitle() -> String {
        return NSLocalizedString("photos_title", comment: "Title for photos section")
    }

    // Локализованное название для заголовка "Сменить пароль"
    static func changePasswordTitle() -> String {
        return NSLocalizedString("change_password", comment: "Title for change password option")
    }
}
