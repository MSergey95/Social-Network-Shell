
import Foundation

struct DocumentItem: Identifiable {
    var id: String
    var name: String
    var url: URL

    var isDirectory: Bool {
        var isDirectory: ObjCBool = false
        FileManager.default.fileExists(atPath: url.path, isDirectory: &isDirectory)
        return isDirectory.boolValue
    }
}
