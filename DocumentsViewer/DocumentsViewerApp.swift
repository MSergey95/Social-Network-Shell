import SwiftUI

@main
struct DocumentsViewerApp: App {
    @StateObject var settings = SettingsModel() // Создаем модель настроек

    var body: some Scene {
        WindowGroup {
            PasswordView() // Показываем сначала экран для ввода пароля
                .environmentObject(settings) // Передаем объект настроек всем представлениям
        }
    }
}
