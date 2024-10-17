import SwiftUI
import RealmSwift
struct ContentView: View {
    var body: some View {
        TabView {
            RandomQuoteView()
                .tabItem {
                    Label("Random Quote", systemImage: "quote.bubble")
                }

            AllQuotesView()
                .tabItem {
                    Label("All Quotes", systemImage: "list.bullet")
                }

            CategoriesView() // Это ссылка на твой отдельный файл CategoriesView
                .tabItem {
                    Label("Categories", systemImage: "folder")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
