import UIKit

final class ProfileViewController: UIViewController {

    private var viewModel: ProfileViewModel!

    static let headerIdent = "header"
    static let photoIdent = "photo"
    static let postIdent = "post"

    static var postTableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(ProfileHeaderView.self, forHeaderFooterViewReuseIdentifier: headerIdent)
        table.register(PhotosTableViewCell.self, forCellReuseIdentifier: photoIdent)
        table.register(PostTableViewCell.self, forCellReuseIdentifier: postIdent)
        table.backgroundColor = .customBackground
        return table
    }()

    // MARK: - Setup section
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel = ProfileViewModel(userProfile: UserProfile(name: "Best Cat", status: "Ready to help"))

        view.backgroundColor = .customBackground
        view.addSubview(Self.postTableView)

        setupConstraints()

        Self.postTableView.dataSource = self
        Self.postTableView.delegate = self

        if #available(iOS 15.0, *) {
            Self.postTableView.sectionHeaderTopPadding = 0
        }

        Self.postTableView.refreshControl = UIRefreshControl()
        Self.postTableView.refreshControl?.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
        Self.postTableView.refreshControl?.tintColor = .customTextColor
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            Self.postTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Self.postTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            Self.postTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            Self.postTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    @objc func reloadTableView() {
        Self.postTableView.reloadData()
        Self.postTableView.refreshControl?.endRefreshing()
    }
}

// MARK: - UITableViewDataSource
extension ProfileViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1 // Блок с фотографиями
        case 1: return viewModel.getPostsCount() // Блок с постами
        default: return 0
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

// MARK: - UITableViewDelegate
extension ProfileViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.photoIdent, for: indexPath) as! PhotosTableViewCell
            cell.backgroundColor = .customBackground
            return cell
        case 1:
            let cell = Self.postTableView.dequeueReusableCell(withIdentifier: Self.postIdent, for: indexPath) as! PostTableViewCell
            let post = viewModel.getPost(at: indexPath.row)
            cell.configPostArray(post: post)
            cell.backgroundColor = .customBackground
            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: Self.headerIdent) as! ProfileHeaderView
            headerView.contentView.backgroundColor = .customBackground
            return headerView
        } else if section == 1 {
            // Контейнер для "Мои записи" и иконки поиска
            let containerView = UIView()
            containerView.backgroundColor = .customBackground

            let myPostsLabel = UILabel()
            myPostsLabel.text = "Мои записи"
            myPostsLabel.font = .systemFont(ofSize: 18, weight: .bold)
            myPostsLabel.textColor = .customTextColor
            myPostsLabel.translatesAutoresizingMaskIntoConstraints = false

            let searchIcon = UIImageView()
            searchIcon.image = UIImage(systemName: "magnifyingglass")
            searchIcon.tintColor = .customTextColor
            searchIcon.translatesAutoresizingMaskIntoConstraints = false

            containerView.addSubview(myPostsLabel)
            containerView.addSubview(searchIcon)

            NSLayoutConstraint.activate([
                myPostsLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                myPostsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),

                searchIcon.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                searchIcon.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])

            return containerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case 0: return 300 // Заголовок и новый блок метрик
        case 1: return 50  // "Мои записи" и поиск
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            navigationController?.pushViewController(PhotosViewController(), animated: true)
        case 1:
            let post = viewModel.getPost(at: indexPath.row)
            print("Просмотр поста: \(post.author)")
        default: break
        }
    }
}
