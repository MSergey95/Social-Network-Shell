

import Foundation
import UIKit

class FileManagerService {
    static let shared = FileManagerService()
    let fileManager = FileManager.default
    let documentsURL: URL

    init() {
        self.documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
    }

    // Получить документы в определенной папке
    func getDocuments(at url: URL) -> [DocumentItem] {
        do {
            let fileURLs = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil)
            return fileURLs.map { url in
                DocumentItem(id: UUID().uuidString, name: url.lastPathComponent, url: url)
            }
        } catch {
            print("Error while getting documents: \(error)")
            return []
        }
    }

    // Сохранение изображения в указанной папке
    func saveImage(image: UIImage, name: String, in directory: URL) -> Bool {
        let imageData = image.jpegData(compressionQuality: 0.8)
        let fileURL = directory.appendingPathComponent(name)
        do {
            try imageData?.write(to: fileURL)
            return true
        } catch {
            print("Error saving image: \(error)")
            return false
        }
    }

    // Удаление документа по URL
    func deleteDocument(at url: URL) -> Bool {
        do {
            try fileManager.removeItem(at: url)
            return true
        } catch {
            print("Error deleting file: \(error)")
            return false
        }
    }
}
