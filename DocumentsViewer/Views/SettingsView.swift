import SwiftUI

struct SettingsView: View {
    @State private var isAlphabeticalOrder: Bool = UserDefaults.standard.bool(forKey: "isAlphabeticalOrder")
    @State private var showFileSize: Bool = UserDefaults.standard.bool(forKey: "showFileSize")
    @State private var showChangePasswordSheet = false

    var body: some View {
        Form {
            Toggle("Sort alphabetically", isOn: $isAlphabeticalOrder)
                .onChange(of: isAlphabeticalOrder) {
                    UserDefaults.standard.set(isAlphabeticalOrder, forKey: "isAlphabeticalOrder")
                }

            Toggle("Show file size", isOn: $showFileSize)
                .onChange(of: showFileSize) {
                    UserDefaults.standard.set(showFileSize, forKey: "showFileSize")
                }

            // Кнопка для смены пароля
            Button(action: {
                showChangePasswordSheet.toggle()
            }) {
                Text("Change Password")
            }
        }
        .navigationTitle("Settings")
        .sheet(isPresented: $showChangePasswordSheet) {
            ChangePasswordView() // Показываем экран для смены пароля
        }
        .onAppear {
            isAlphabeticalOrder = UserDefaults.standard.bool(forKey: "isAlphabeticalOrder")
            showFileSize = UserDefaults.standard.bool(forKey: "showFileSize")
        }
    }
}
