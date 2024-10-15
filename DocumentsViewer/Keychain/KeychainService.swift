import KeychainAccess

protocol KeychainServiceProtocol {
    func savePassword(_ password: String)
    func getPassword() -> String?
    func updatePassword(_ password: String)
}

struct KeychainService: KeychainServiceProtocol {
    static let shared = KeychainService() // Статический экземпляр

    private let keychain = Keychain(service: "com.yourapp.documentsviewer")

    func savePassword(_ password: String) {
        do {
            try keychain.set(password, key: "userPassword")
        } catch {
            print("Error saving password: \(error)")
        }
    }

    func getPassword() -> String? {
        return try? keychain.get("userPassword")
    }

    func updatePassword(_ password: String) {
        savePassword(password)
    }
}
