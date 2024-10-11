import SwiftUI

struct ContentView: View {
    @State private var documents: [DocumentItem] = []
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    @State private var showNewFolderSheet = false
    @State private var newFolderName = ""
    var currentFolderURL: URL
    var folderTitle: String // Передаем название папки

    var body: some View {
        NavigationView {
            List {
                ForEach(documents, id: \.id) { document in
                    if document.isDirectory && !document.name.isEmpty { // Проверяем, чтобы имя не было пустым
                        NavigationLink(destination: ContentView(currentFolderURL: document.url, folderTitle: document.name)) {
                            Text(document.name)
                        }
                    } else if !document.name.isEmpty { // Проверяем, чтобы имя файла не было пустым
                        Text(document.name)
                    }
                }
                .onDelete(perform: deleteDocument)
            }
            .navigationBarTitle(folderTitle) // Меняем заголовок в зависимости от папки
            .navigationBarItems(trailing: HStack { // Обе кнопки справа
                Button(action: {
                    showNewFolderSheet = true
                }) {
                    Image(systemName: "folder.badge.plus")
                }
                Button(action: {
                    showImagePicker.toggle()
                }) {
                    Image(systemName: "plus")
                }
            })
            .sheet(isPresented: $showImagePicker, onDismiss: saveImage) {
                ImagePicker(image: $selectedImage)
            }
            .sheet(isPresented: $showNewFolderSheet) {
                CreateFolderView(newFolderName: $newFolderName, onCreate: createNewFolder)
            }
            .onAppear {
                documents = FileManagerService.shared.getDocuments(at: currentFolderURL)
            }
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
                newFolderName = "" // Сбрасываем имя новой папки
            } catch {
                print("Error creating folder: \(error.localizedDescription)")
            }
        }
    }
}

struct CreateFolderView: View {
    @Binding var newFolderName: String
    var onCreate: () -> Void

    var body: some View {
        VStack {
            Text("Create New Folder")
                .font(.headline)
                .padding()

            TextField("Folder Name", text: $newFolderName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            HStack {
                Button("Cancel") {
                    UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows
                        .first?.rootViewController?.dismiss(animated: true, completion: nil)
                }
                Button("Create") {
                    onCreate()
                    UIApplication.shared.connectedScenes
                        .compactMap { $0 as? UIWindowScene }
                        .first?.windows
                        .first?.rootViewController?.dismiss(animated: true, completion: nil)
                }
            }
            .padding()
        }
    }
}
