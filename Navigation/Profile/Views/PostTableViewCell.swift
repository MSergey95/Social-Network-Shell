import Foundation
import UIKit


class PostTableViewCell: UITableViewCell {
    private var isLiked: Bool = false
    private var viewCounter = 0
    var post: Post?

    // MARK: Visual objects

    var postAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .customTextColor // Используем кастомный цвет текста
        label.numberOfLines = 2
        return label
    }()

    var postImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .customBackground // Используем кастомный цвет фона
        image.contentMode = .scaleAspectFill
        image.isUserInteractionEnabled = true // Включаем взаимодействие для изображения
        return image
    }()

    var postDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .customTextColor // Используем кастомный цвет текста
        label.numberOfLines = 0
        return label
    }()

    var postLikes: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .customTextColor // Используем кастомный цвет текста
        return label
    }()

    var postViews: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16)
        label.textColor = .customTextColor // Используем кастомный цвет текста
        return label
    }()

    // MARK: - Init section

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubviews(postAuthor, postImage, postDescription, postLikes, postViews)
        setupConstraints()
        self.selectionStyle = .default

        // Добавляем жест двойного нажатия на изображение
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTap.numberOfTapsRequired = 2
        postImage.addGestureRecognizer(doubleTap)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            postAuthor.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indent),
            postAuthor.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            postAuthor.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),

            postImage.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            postImage.heightAnchor.constraint(equalTo: postImage.widthAnchor, multiplier: 0.96),
            postImage.topAnchor.constraint(equalTo: postAuthor.bottomAnchor, constant: LayoutConstants.indent),

            postDescription.topAnchor.constraint(equalTo: postImage.bottomAnchor, constant: LayoutConstants.indent),
            postDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            postDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),

            postLikes.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: LayoutConstants.indent),
            postLikes.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.leadingMargin),
            postLikes.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent),

            postViews.topAnchor.constraint(equalTo: postDescription.bottomAnchor, constant: LayoutConstants.indent),
            postViews.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: LayoutConstants.trailingMargin),
            postViews.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indent)
        ])
    }

    // MARK: - Run loop
    func configPostArray(post: Post) {
        self.post = post
        postAuthor.text = post.author
        postDescription.text = post.description

        // Загружаем изображение из ассетов
        if let image = UIImage(named: post.image) {
            postImage.image = image
        } else {
            postImage.image = UIImage(named: "defaultImage") // Обработка случая, если изображение не найдено
        }

        // Локализация лайков и просмотров
        postLikes.text = "like_count".localizedWithLikes(count: post.likes)
        viewCounter = post.views
        postViews.text = "views_count".localizedWithViews(count: viewCounter)
    }

    func incrementPostViewsCounter() {
        viewCounter += 1
        postViews.text = "views_count".localizedWithViews(count: viewCounter)
    }
    // MARK: - Handle double tap
    @objc private func handleDoubleTap() {
        guard let post = post else { return }

        // Проверяем, есть ли пост уже в избранном
        let favoritePosts = CoreDataManager.shared.fetchFavoritePosts()
        if favoritePosts.contains(where: { $0.title == post.author }) {
            // Если пост уже в избранном, то удаляем его и уменьшаем лайк
            CoreDataManager.shared.removeFavoritePost(withTitle: post.author)
            if isLiked {
                isLiked = false
                post.likes -= 1
                postLikes.text = "like_count".localizedWithLikes(count: post.likes)
            }
            print("Этот пост удален из избранного")
        } else {
            // Добавляем пост в избранное и увеличиваем лайк, если еще не было лайка
            CoreDataManager.shared.addFavoritePost(id: UUID().uuidString, title: post.author, date: Date(), image: post.image)
            print("Post added to favorites: \(post.author)")

            // Увеличиваем количество лайков, если лайк еще не был поставлен
            if !isLiked {
                isLiked = true
                post.likes += 1
                postLikes.text = "like_count".localizedWithLikes(count: post.likes)
            }
        }

        // Обновляем UI с сообщением
        let alertTitle = isLiked ? "Успех" : "Удалено"
        let alertMessage = isLiked ? "Пост добавлен в избранное" : "Пост удален из избранного"
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        parentViewController?.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension to get parent view controller
extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while let responder = parentResponder {
            parentResponder = responder.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
extension String {
    // Метод для обычной локализации
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }

    // Метод для локализации с числом для лайков
    func localizedWithLikes(count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("like_count", tableName: "Localizable", comment: "Likes count"), count)
    }

    // Метод для локализации с числом для просмотров
    func localizedWithViews(count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString("views_count", tableName: "Localizable", comment: "Views count"), count)
    }
}
