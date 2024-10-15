
import SwiftUI

struct DetailsView: View {
    var document: DocumentItem // Данные документа, которые передаем

    var body: some View {
        VStack {
            if let image = UIImage(contentsOfFile: document.url.path) {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                Text("File: \(document.name)")
                    .padding()
            }

            Spacer()
        }
        .navigationBarTitle(document.name, displayMode: .inline)
    }
}
