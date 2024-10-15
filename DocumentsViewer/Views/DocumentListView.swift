import SwiftUI

struct DocumentListView: View {
    @State private var documents: [DocumentItem] = []
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showNewFolderAlert = false
    @State private var newFolderName = ""
    let currentFolderURL: URL

    var body: some View {
        NavigationView {
            List {
                ForEach(documents) { document in
                    Text(document.name)
                }
                .onDelete(perform: deleteDocument)
            }
            .navigationBarTitle("Documents")
            .navigationBarItems(
                leading: Button(action: {
                    showNewFolderAlert = true
                }) {
                    Image(systemName: "folder.badge.plus")
                },
                trailing: Button(action: {
                    self.showImagePicker.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showImagePicker, onDismiss: saveImage) {
                ImagePicker(image: self.$selectedImage)
            }
            .onAppear {
                documents = FileManagerService.shared.getDocuments(at: currentFolderURL)
            }
            .background(
                TextFieldAlertView(text: $newFolderName, title: "Create New Folder", message: "Enter a name for the new folder", placeholder: "Folder name", onCommit: createNewFolder)
                    .opacity(showNewFolderAlert ? 1 : 0)
            )
        }
    }

    private func saveImage() {
        if let selectedImage = selectedImage {
            let imageName = UUID().uuidString + ".jpeg"
            if FileManagerService.shared.saveImage(image: selectedImage, name: imageName, in: currentFolderURL) {
                documents = FileManagerService.shared.getDocuments(at: currentFolderURL)
            }
        }
    }

    private func deleteDocument(at offsets: IndexSet) {
        if let index = offsets.first {
            let document = documents[index]
            _ = FileManagerService.shared.deleteDocument(at: document.url)
            documents = FileManagerService.shared.getDocuments(at: currentFolderURL)
        }
    }

    private func createNewFolder() {
        if !newFolderName.isEmpty {
            let newFolderURL = currentFolderURL.appendingPathComponent(newFolderName)
            do {
                try FileManager.default.createDirectory(at: newFolderURL, withIntermediateDirectories: true, attributes: nil)
                documents = FileManagerService.shared.getDocuments(at: currentFolderURL)
                newFolderName = ""
                showNewFolderAlert = false
            } catch {
                print("Error creating folder: \(error.localizedDescription)")
            }
        }
    }
}
