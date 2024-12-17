import UIKit

final class FeedViewController: UIViewController {
    private var posts: [Post] = []
    private let profileViewModel: ProfileViewModel

    // Инициализация с данными профиля
    init(profileViewModel: ProfileViewModel) {
        self.profileViewModel = profileViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // Таблица для отображения ленты
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        loadData()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    private func loadData() {
        // Получаем пользовательские посты
        for index in 0..<profileViewModel.getPostsCount() {
            posts.append(profileViewModel.getPost(at: index))
        }

        // Добавляем статичные "фейковые" посты
        let otherPosts = [
            Post(author: "Иван Иванов", description: "Какой красивый закат!", image: "Image1", likes: 23, views: 40),
            Post(author: "Мария Смирнова", description: "Моё утро начинается с кофе ☕", image: "Image1", likes: 15, views: 22),
            Post(author: "Петр Петров", description: "Велопрогулка по парку!", image: "Image1", likes: 30, views: 50)
        ]

        posts.append(contentsOf: otherPosts)

        // Перемешиваем все посты случайным образом
        posts.shuffle()

        // Обновляем таблицу
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            return UITableViewCell()
        }
        cell.configPostArray(post: posts[indexPath.row])
        return cell
    }
}
