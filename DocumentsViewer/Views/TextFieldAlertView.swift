import SwiftUI
import UIKit

struct TextFieldAlertView: UIViewControllerRepresentable {
    @Binding var text: String
    let title: String
    let message: String
    let placeholder: String
    let onCommit: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController() // Empty view controller
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        guard context.coordinator.alert == nil else { return }

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addTextField { textField in
            textField.placeholder = placeholder
            textField.text = text
            textField.addTarget(context.coordinator, action: #selector(Coordinator.textChanged(_:)), for: .editingChanged)
        }

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel) { _ in
            context.coordinator.alert = nil
        })

        alert.addAction(UIAlertAction(title: "Create", style: .default) { _ in
            onCommit()
            context.coordinator.alert = nil
        })

        DispatchQueue.main.async {
            uiViewController.present(alert, animated: true, completion: nil)
        }

        context.coordinator.alert = alert
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var alert: UIAlertController?
        var parent: TextFieldAlertView

        init(_ parent: TextFieldAlertView) {
            self.parent = parent
        }

        @objc func textChanged(_ sender: UITextField) {
            parent.text = sender.text ?? ""
        }
    }
}
