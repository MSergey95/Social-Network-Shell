import UIKit
import StorageService
class ProfileViewController: UIViewController {
    private let tableView = UITableView() // Исправлено имя переменной
    private var posts: [Post] = []

    override func viewDidLoad() {
           super.viewDidLoad()
           #if DEBUG
           self.view.backgroundColor = .red
           #else
           self.view.backgroundColor = .green
           #endif
           configurePosts()
           setupTableView()
       }


    private func configurePosts() {
        posts = [
            Post(author: "eni.official", description: "Перед битвой за Ретузу", image: "Eni", likes: 100, views: 150, title: "Title 1", content: "Content 1"),
            Post(author: "witcher.official", description: "Новые кадры со съемок третьего сезона сериала \"Ведьмак\"", image: "Witcher", likes: 240, views: 312, title: "Title 2", content: "Content 2"),
            Post(author: "ciri.of.rivia", description: "Приключения Цири в пустыне", image: "Ciri", likes: 300, views: 400, title: "Title 3", content: "Content 3"),
            Post(author: "pixar.cat", description: "Новая картинка в стиле Pixar", image: "CatPixarStyle", likes: 500, views: 600, title: "Title 4", content: "Content 4")
        ]
    }

    private func setupTableView() {
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: PostTableViewCell.identifier) // Исправлено имя переменной
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .lightGray // Исправлено имя переменной

        // Настройка ProfileTableHeaderView для нулевой секции
        let headerView = ProfileHeaderView()
        headerView.backgroundColor = .lightGray
        headerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 200) // Установка желаемой высоты
        tableView.tableHeaderView = headerView

        view.addSubview(tableView) // Исправлено имя переменной
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        let post = posts[indexPath.row]
        cell.configure(with: post)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension // Высота ячейки рассчитывается автоматически
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350 // Предполагаемая высота ячейки
    }
}
