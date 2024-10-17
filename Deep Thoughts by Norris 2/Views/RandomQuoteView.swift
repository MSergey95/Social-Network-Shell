import SwiftUI
import RealmSwift

struct RandomQuoteView: View {
    @State private var randomQuote: String = "Нажми на кнопку, чтобы загрузить цитату"

    var body: some View {
        VStack {
            Text("Deep Thoughts by Norris 2")
                .font(.title)
                .padding()

            Button(action: {
                fetchRandomQuote()
            }) {
                Text("Загрузить случайную цитату")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }

            Text(randomQuote)
                .padding()
                .font(.headline)
        }
        .padding()
    }

    func fetchRandomQuote() {
        let urlString = "https://api.chucknorris.io/jokes/random"
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data, error == nil {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                       let id = json["id"] as? String,
                       let text = json["value"] as? String {

                        let category = (json["category"] as? [String])?.first

                        // Логируем полученные данные
                        print("Полученные данные: \(json)")

                        // Обновляем цитату на экране
                        DispatchQueue.main.async {
                            self.randomQuote = text
                        }

                        // Сохраняем цитату в базу Realm
                        Task {
                            await saveQuoteToRealm(id: id, text: text, category: category)
                        }
                    } else {
                        print("Ошибка при разборе JSON")
                    }
                } catch {
                    print("Ошибка при разборе JSON: \(error)")
                }
            } else {
                print("Ошибка загрузки данных: \(String(describing: error))")
            }
        }.resume()
    }

    @MainActor
    func saveQuoteToRealm(id: String, text: String, category: String?) {
        do {
            let realm = try Realm()

            try realm.write {
                // Проверка на дублирование цитаты
                if realm.object(ofType: Quote.self, forPrimaryKey: id) == nil {
                    let quote = Quote()
                    quote.id = id
                    quote.text = text
                    quote.category = category
                    quote.date = Date()

                    // Проверка, есть ли категория
                    if let categoryName = category, !categoryName.isEmpty {
                        var existingCategory = realm.object(ofType: Category.self, forPrimaryKey: categoryName)
                        if existingCategory == nil {
                            existingCategory = Category()
                            existingCategory?.name = categoryName
                            realm.add(existingCategory!)
                        }
                        // Добавляем цитату в категорию
                        existingCategory?.quotes.append(quote)
                    } else {
                        // Если категории нет, просто сохраняем цитату
                        realm.add(quote, update: .modified)
                    }
                } else {
                    print("Цитата уже существует")
                }
            }
        } catch {
            print("Ошибка сохранения цитаты в Realm: \(error)")
        }
    }
}
