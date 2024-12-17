import UIKit

class PhotosTableViewCell: UITableViewCell {

    // MARK: Visual objects

    var labelPhotos: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = LocalizationHelper.photosTitle()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .customTextColor // Используем кастомный цвет для текста
        return label
    }()

    var arrowImage: UIImageView = {
        let arrow = UIImageView()
        arrow.translatesAutoresizingMaskIntoConstraints = false
        arrow.image = UIImage(systemName: "arrow.right")?.withTintColor(.customTextColor, renderingMode: .alwaysOriginal) // Используем кастомный цвет
        return arrow
    }()

    var stackViewImage: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.spacing = 8
        return stack
    }()

    func getPreviewImage(index: Int) -> UIImageView {
        let preview = UIImageView()
        preview.translatesAutoresizingMaskIntoConstraints = false
        preview.image = Photos.shared.examples[index]
        preview.contentMode = .scaleAspectFill
        preview.layer.cornerRadius = 6
        preview.clipsToBounds = true
        return preview
    }

    // MARK: - Init section

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        contentView.addSubviews(labelPhotos, arrowImage, stackViewImage)

        setupPreviews()
        setupConstraints()

        contentView.backgroundColor = .customBackground // Устанавливаем кастомный фон для ячейки
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // get 3 preview images
    private func setupPreviews() {
        for ind in 0...2 {
            let image = getPreviewImage(index: ind)
            stackViewImage.addArrangedSubview(image)
            NSLayoutConstraint.activate([
                image.widthAnchor.constraint(greaterThanOrEqualToConstant: (contentView.frame.width - 24) / 4),
                image.heightAnchor.constraint(equalTo: image.widthAnchor, multiplier: 0.56),
            ])
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            labelPhotos.topAnchor.constraint(equalTo: contentView.topAnchor, constant: LayoutConstants.indentTwelve),
            labelPhotos.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            labelPhotos.widthAnchor.constraint(equalToConstant: 80),
            labelPhotos.heightAnchor.constraint(equalToConstant: 40),

            arrowImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentTwelve),
            arrowImage.centerYAnchor.constraint(equalTo: labelPhotos.centerYAnchor),
            arrowImage.heightAnchor.constraint(equalToConstant: 40),
            arrowImage.widthAnchor.constraint(equalToConstant: 40),

            stackViewImage.topAnchor.constraint(equalTo: labelPhotos.bottomAnchor, constant: LayoutConstants.indentTwelve),
            stackViewImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: LayoutConstants.indentTwelve),
            stackViewImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -LayoutConstants.indentTwelve),
            stackViewImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -LayoutConstants.indentTwelve),
        ])
    }
}
