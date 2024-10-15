import SwiftUI

struct ChangePasswordView: View {
    @State private var oldPassword: String = "" // Для ввода старого пароля
    @State private var newPassword: String = "" // Для нового пароля
    @State private var repeatNewPassword: String = "" // Для подтверждения нового пароля
    @State private var errorMessage: String = "" // Для отображения ошибок
    @State private var isOldPasswordCorrect = false // Для отслеживания правильности старого пароля

    private let keychainService: KeychainServiceProtocol = KeychainService()

    var body: some View {
        VStack(spacing: 16) {
            // Поле для ввода старого пароля (показывается до его проверки)
            if !isOldPasswordCorrect {
                SecureField("Введите текущий пароль", text: $oldPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            // Если старый пароль верен, показываем поля для ввода нового пароля
            if isOldPasswordCorrect {
                SecureField("Введите новый пароль", text: $newPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                SecureField("Повторите новый пароль", text: $repeatNewPassword)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            }

            // Отображение ошибки
            Text(errorMessage)
                .foregroundColor(.red)
                .padding()

            // Кнопка подтверждения
            Button(action: handlePasswordChange) {
                Text(isOldPasswordCorrect ? "Сменить пароль" : "Подтвердить текущий пароль")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
    }

    private func handlePasswordChange() {
        // Если старый пароль не проверен
        if !isOldPasswordCorrect {
            if let savedPassword = keychainService.getPassword(), savedPassword == oldPassword {
                isOldPasswordCorrect = true // Старый пароль верен
                errorMessage = ""
            } else {
                errorMessage = "Неверный текущий пароль"
            }
        } else {
            // Если старый пароль верен, проверяем новый пароль
            if newPassword == repeatNewPassword {
                if newPassword.count >= 4 {
                    keychainService.updatePassword(newPassword) // Обновляем пароль в Keychain
                    errorMessage = "Пароль успешно изменен"
                    oldPassword = ""
                    newPassword = ""
                    repeatNewPassword = ""
                } else {
                    errorMessage = "Пароль должен содержать минимум 4 символа"
                }
            } else {
                errorMessage = "Новые пароли не совпадают"
            }
        }
    }
}
