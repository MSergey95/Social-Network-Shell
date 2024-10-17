import Foundation
import RealmSwift

class Quote: Object, Identifiable {
    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var text: String = ""
    @objc dynamic var category: String? = nil
    @objc dynamic var date: Date = Date()

    override static func primaryKey() -> String? {
        return "id"
    }
}

class Category: Object, Identifiable {
    @objc dynamic var name: String = ""
    let quotes = List<Quote>()  // Список цитат в категории

    override static func primaryKey() -> String? {
        return "name"
    }
}
