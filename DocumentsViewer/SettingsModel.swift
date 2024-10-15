import Foundation
import Combine

class SettingsModel: ObservableObject {
    @Published var isAlphabeticalOrder: Bool {
        didSet {
            UserDefaults.standard.set(isAlphabeticalOrder, forKey: "isAlphabeticalOrder")
        }
    }

    @Published var showFileSize: Bool {
        didSet {
            UserDefaults.standard.set(showFileSize, forKey: "showFileSize")
        }
    }

    init() {
        self.isAlphabeticalOrder = UserDefaults.standard.bool(forKey: "isAlphabeticalOrder")
        self.showFileSize = UserDefaults.standard.bool(forKey: "showFileSize")
    }
}
