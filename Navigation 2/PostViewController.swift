

import UIKit
import StorageService
class PostViewController: UIViewController {
    var post: Post?
    private let contentLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Info", style: .plain, target: self, action: #selector(showInfoViewController))
        view.backgroundColor = .blue
        title = post?.title // Устанавливаем заголовок
        contentLabel.numberOfLines = 0 // Позволяет метке иметь несколько строк
        contentLabel.textColor = .white
        contentLabel.textAlignment = .center
        contentLabel.text = post?.content // Устанавливаем текст из содержимого поста
        view.addSubview(contentLabel)
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    @objc func showInfoViewController() {
        let infoViewController = InfoViewController()
        present(infoViewController, animated: true, completion: nil)
    }
}

