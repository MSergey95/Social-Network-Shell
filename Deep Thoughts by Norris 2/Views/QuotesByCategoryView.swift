import SwiftUI
import RealmSwift

struct QuotesByCategoryView: View {
    var category: Category

    var body: some View {
        List {
            ForEach(category.quotes, id: \.id) { quote in
                VStack(alignment: .leading) {
                    Text(quote.text)
                        .font(.body)
                    Text("\(quote.date, formatter: dateFormatter())") // Форматирование даты с временем
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .navigationTitle(category.name)
    }
}

// Форматтер для отображения даты с временем
func dateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short // Показывает часы и минуты
    return formatter
}
