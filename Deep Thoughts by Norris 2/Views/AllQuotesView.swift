import SwiftUI
import RealmSwift

struct AllQuotesView: View {
    @ObservedResults(Quote.self, sortDescriptor: SortDescriptor(keyPath: "date", ascending: false)) var quotes

    var body: some View {
        NavigationView {
            List {
                ForEach(quotes, id: \.id) { quote in
                    VStack(alignment: .leading) {
                        Text(quote.text)
                            .font(.body)
                        Text("\(quote.date, formatter: dateFormatter())") // Добавляем время в отображение даты
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("All Quotes")
        }
    }
}

extension DateFormatter {
    static let customFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short // Добавим отображение времени (часы и минуты)
        return formatter
    }()
}
