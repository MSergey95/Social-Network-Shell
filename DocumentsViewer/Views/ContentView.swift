import SwiftUI

struct ContentView: View {
    @EnvironmentObject var settings: SettingsModel
    @State private var documents: [DocumentItem] = []

    var currentFolderURL: URL
    var folderTitle: String

    var body: some View {
        NavigationView {
            List {
                ForEach(sortedDocuments()) { document in
                    if document.isDirectory {
                        NavigationLink(destination: ContentView(currentFolderURL: document.url, folderTitle: document.name)) {
                            Text(document.name)
                        }
                    } else {
                        HStack {
                            Text(document.name)
                            if settings.showFileSize {
                                Spacer()
                                Text(metadataForFile(at: document.url))
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle(folderTitle)
            .onAppear {
                documents = FileManagerService.shared.getDocuments(at: currentFolderURL)
            }
        }
    }

    private func sortedDocuments() -> [DocumentItem] {
        documents.sorted(by: settings.isAlphabeticalOrder ? { $0.name < $1.name } : { $0.name > $1.name })
    }

    private func metadataForFile(at url: URL) -> String {
        do {
            let attributes = try FileManager.default.attributesOfItem(atPath: url.path)
            if let fileSize = attributes[.size] as? Int64, let creationDate = attributes[.creationDate] as? Date {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
                return "\(fileSize) bytes, \(formatter.string(from: creationDate))"
            }
        } catch {
            print("Error retrieving file metadata: \(error.localizedDescription)")
        }
        return ""
    }
}
