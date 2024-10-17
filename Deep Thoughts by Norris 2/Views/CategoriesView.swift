import SwiftUI
import RealmSwift

struct CategoriesView: View {
    @ObservedResults(Category.self) var categories // Наблюдаем за категориями

    var body: some View {
        NavigationView {
            List {
                ForEach(categories, id: \.name) { category in
                    NavigationLink(destination: QuotesByCategoryView(category: category)) {
                        Text(category.name)
                    }
                }
            }
            .navigationTitle("Categories")
        }
        .onAppear {
            fetchCategories() // Загружаем категории при появлении экрана
        }
    }
}

// Функция для загрузки категорий
func fetchCategories() {
    let urlString = "https://api.chucknorris.io/jokes/categories"
    guard let url = URL(string: urlString) else { return }

    URLSession.shared.dataTask(with: url) { data, _, error in
        if let data = data, error == nil {
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String] {

                    // Логирование категорий
                    print("Полученные категории: \(json)")

                    Task {
                        await saveCategoriesToRealm(categories: json)
                    }
                }
            } catch {
                print("Ошибка при разборе JSON: \(error)")
            }
        }
    }.resume()
}

// Функция для сохранения категорий в Realm
@MainActor
func saveCategoriesToRealm(categories: [String]) {
    do {
        let realm = try Realm()

        try realm.write {
            for categoryName in categories {
                let existingCategory = realm.object(ofType: Category.self, forPrimaryKey: categoryName)
                if existingCategory == nil {
                    let newCategory = Category()
                    newCategory.name = categoryName
                    realm.add(newCategory, update: .modified)
                }
            }
        }
    } catch {
        print("Ошибка сохранения категорий в Realm: \(error)")
    }
}
