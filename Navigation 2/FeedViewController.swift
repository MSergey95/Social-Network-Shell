import UIKit
import StorageService

class FeedViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .darkGray

        let showPostButton = UIButton(type: .system)
        showPostButton.setTitle("Show Post", for: .normal)
        showPostButton.addTarget(self, action: #selector(showPost), for: .touchUpInside)
        view.addSubview(showPostButton)
        showPostButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(showPostButton)

        NSLayoutConstraint.activate([
            showPostButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showPostButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showPostButton.widthAnchor.constraint(equalToConstant: 200),
            showPostButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func showPost() {
        let postViewController = PostViewController()
        let post = Post(
            author: "Some Author",
            description: "Some Description",
            image: "SomeImage",
            likes: 0,
            views: 0,
            title: "Some Post Title",
            content: "Test content"
        )
        postViewController.post = post
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
