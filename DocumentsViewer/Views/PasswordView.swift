import SwiftUI
import KeychainAccess

struct PasswordView: View {
    @State private var password: String = ""
    @State private var repeatPassword: String = ""
    @State private var hasPassword = false
    @State private var errorMessage: String = ""
    @State private var isCreatingPassword = false
    @State private var isAuthenticated = false // Состояние для отображения MainTabView
    private let keychainService = KeychainService() // Создаем экземпляр сервиса

    var body: some View {
        if isAuthenticated {
            MainTabView() // Переход к главному экрану после аутентификации
        } else {
            VStack {
                SecureField("Введите пароль", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                if isCreatingPassword {
                    SecureField("Повторите пароль", text: $repeatPassword)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                }

                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()

                Button(action: {
                    handlePasswordAction()
                }) {
                    Text(isCreatingPassword ? "Повторите пароль" : hasPassword ? "Введите пароль" : "Создать пароль")
                }
                .padding()
            }
            .onAppear {
                checkIfPasswordExists()
            }
        }
    }

    private func checkIfPasswordExists() {
        if let _ = keychainService.getPassword() {
            hasPassword = true
        } else {
            hasPassword = false
        }
    }

    private func handlePasswordAction() {
        if isCreatingPassword {
            if password == repeatPassword {
                if password.count >= 4 {
                    keychainService.savePassword(password) // Сохраняем пароль через экземпляр сервиса
                    isAuthenticated = true // Успешная аутентификация
                } else {
                    errorMessage = "Пароль должен содержать минимум 4 символа"
                }
            } else {
                errorMessage = "Пароли не совпадают"
            }
        } else {
            if hasPassword {
                if let savedPassword = keychainService.getPassword(), savedPassword == password {
                    isAuthenticated = true // Пароль верный, переходим к основному экрану
                } else {
                    errorMessage = "Неверный пароль"
                }
            } else {
                isCreatingPassword = true
            }
        }
    }
}
