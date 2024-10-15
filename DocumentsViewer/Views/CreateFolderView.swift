import SwiftUI

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
        .padding()
    }
}
