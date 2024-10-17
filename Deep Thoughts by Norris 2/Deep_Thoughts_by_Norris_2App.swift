import SwiftUI
import RealmSwift

@main
struct MyApp: App {
    init() {
        do {
            let _ = try Realm()
            print("Realm успешно инициализирован")
        } catch {
            print("Ошибка инициализации Realm: \(error)")
        }
    }

    var body: some Scene {
        WindowGroup {
            TabView {
                RandomQuoteView()
                    .tabItem {
                        Label("Random Quote", systemImage: "quote.bubble")
                    }

                AllQuotesView()
                    .tabItem {
                        Label("All Quotes", systemImage: "list.bullet")
                    }

                CategoriesView()
                    .tabItem {
                        Label("Categories", systemImage: "folder")
                    }
            }
        }
    }
}
