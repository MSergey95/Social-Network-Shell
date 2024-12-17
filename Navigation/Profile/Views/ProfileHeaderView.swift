import UIKit

final class ProfileHeaderView: UITableViewHeaderFooterView {

    // MARK: - UI Components
    private let fullNameLabel = UILabel()
    private let avatarImageView = UIImageView()
    private let statusLabel = UILabel()
    private let statusTextField = UITextField()
    private let setStatusButton = UIButton()
    private let metricsStackView = UIStackView()
    private let actionsStackView = UIStackView()
    private let photosContainerView = UIView()

    private var statusText = "Ready to help"

    // MARK: - Init
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        setupAvatarImage()
        setupFullNameLabel()
        setupStatusLabel()
        setupStatusTextField()
        setupStatusButton()
        setupMetricsStackView()
        setupActionsStackView() // Добавляем новый блок с иконками
        setupPhotosContainer()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - UI Setup Methods

    private func setupAvatarImage() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.image = UIImage(named: "teo")
        avatarImageView.layer.cornerRadius = 64
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = UIColor.gray.cgColor
        addSubview(avatarImageView)

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 128),
            avatarImageView.heightAnchor.constraint(equalToConstant: 128)
        ])
    }

    private func setupFullNameLabel() {
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.text = "Pluto"
        fullNameLabel.font = .boldSystemFont(ofSize: 18)
        fullNameLabel.textColor = .black
        addSubview(fullNameLabel)

        NSLayoutConstraint.activate([
            fullNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupStatusLabel() {
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.text = statusText
        statusLabel.textColor = .gray
        statusLabel.font = .systemFont(ofSize: 16)
        addSubview(statusLabel)

        NSLayoutConstraint.activate([
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor)
        ])
    }

    private func setupStatusTextField() {
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.borderStyle = .roundedRect
        statusTextField.placeholder = "Enter new status..."
        statusTextField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)
        addSubview(statusTextField)

        NSLayoutConstraint.activate([
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 8),
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor)
        ])
    }

    private func setupStatusButton() {
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.setTitle("Обновить статус", for: .normal)
        setStatusButton.backgroundColor = .systemBlue
        setStatusButton.layer.cornerRadius = 8
        setStatusButton.addTarget(self, action: #selector(updateStatus), for: .touchUpInside)
        addSubview(setStatusButton)

        NSLayoutConstraint.activate([
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 12),
            setStatusButton.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            setStatusButton.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            setStatusButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupMetricsStackView() {
        let metrics = [
            createMetricLabel(value: "1400", title: "публикаций"),
            createMetricLabel(value: "477", title: "подписок"),
            createMetricLabel(value: "161 тыс.", title: "подписчиков")
        ]

        metricsStackView.translatesAutoresizingMaskIntoConstraints = false
        metricsStackView.axis = .horizontal
        metricsStackView.alignment = .center
        metricsStackView.distribution = .equalCentering

        metrics.forEach { metricsStackView.addArrangedSubview($0) }
        addSubview(metricsStackView)

        NSLayoutConstraint.activate([
            metricsStackView.topAnchor.constraint(equalTo: setStatusButton.bottomAnchor, constant: 12),
            metricsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            metricsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private let separatorView = UIView() // Линия разделитель

    private func setupActionsStackView() {
        // Линия сверху
        separatorView.translatesAutoresizingMaskIntoConstraints = false
        separatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3) // Едва заметная линия
        addSubview(separatorView)

        // Создаём блок "Запись, История, Фото"
        let actions = [
            createActionView(imageName: "pencil", title: "Запись"),
            createActionView(imageName: "clock", title: "История"),
            createActionView(imageName: "photo", title: "Фото")
        ]

        actionsStackView.translatesAutoresizingMaskIntoConstraints = false
        actionsStackView.axis = .horizontal
        actionsStackView.alignment = .center
        actionsStackView.distribution = .equalSpacing
        actionsStackView.spacing = 20 // Чуть больше отступ между элементами

        actions.forEach { actionsStackView.addArrangedSubview($0) }
        addSubview(actionsStackView)

        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(equalTo: metricsStackView.bottomAnchor, constant: 8),
            separatorView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            separatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            separatorView.heightAnchor.constraint(equalToConstant: 1),

            actionsStackView.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 12), // Чуть больше отступ от линии
            actionsStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            actionsStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    private func setupPhotosContainer() {
        photosContainerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(photosContainerView)

        NSLayoutConstraint.activate([
            photosContainerView.topAnchor.constraint(equalTo: actionsStackView.bottomAnchor, constant: 4), // Сдвигаем выше
            photosContainerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            photosContainerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            photosContainerView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    // MARK: - Helper Methods
    private func createMetricLabel(value: String, title: String) -> UIStackView {
        let valueLabel = UILabel()
        valueLabel.text = value
        valueLabel.font = .boldSystemFont(ofSize: 18)
        valueLabel.textColor = .black
        valueLabel.textAlignment = .center

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 12)
        titleLabel.textColor = .gray
        titleLabel.textAlignment = .center

        let stackView = UIStackView(arrangedSubviews: [valueLabel, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 2 // Небольшой отступ между цифрой и текстом

        return stackView
    }
    private func createActionView(imageName: String, title: String) -> UIStackView {
        // Создаём иконку
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: imageName) // Используем системные иконки
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true // Увеличиваем размер иконок
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true

        // Создаём заголовок
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center

        // Объединяем в StackView
        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 6 // Чуть больше отступ между иконкой и текстом

        return stackView
    }
    // MARK: - Actions

    @objc private func statusTextChanged(_ textField: UITextField) {
        statusText = textField.text ?? ""
    }

    @objc private func updateStatus() {
        statusLabel.text = statusText
    }
}
