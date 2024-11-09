import SwiftUI

struct ContentView: View {
    @State private var titleOn = true

    var body: some View {
        TabView {
            InfoView(titleOn: titleOn)
                .tabItem {
                    Label("База знаний", systemImage: "book.closed")
                }

            HelloView()
                .tabItem {
                    Label("Hello", systemImage: "face.smiling")
                }

            // Передаем привязку к переменной titleOn в SettingsView
            SettingsView(titleOn: $titleOn)
                .tabItem {
                    Label("Настройки", systemImage: "gearshape")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
