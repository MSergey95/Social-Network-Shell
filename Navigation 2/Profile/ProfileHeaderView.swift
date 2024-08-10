import UIKit
import StorageService

class ProfileHeaderView: UIView, UITextFieldDelegate {

    var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 64 // Корректное значение радиуса для круглого изображения
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "testAvatar")
        return imageView
    }()

    var fullNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Student of Witcher's academy"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()

    var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Waiting for something..."
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular) // Изменено на 17, чтобы соответствовать идеальному коду
        return label
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        textField.delegate = self
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.gray.cgColor // Изменено на серый цвет, чтобы соответствовать идеальному коду
        textField.layer.cornerRadius = 8 // Изменено на 8, чтобы соответствовать идеальному коду
        textField.backgroundColor = .white
        textField.clipsToBounds = true // Обрезать фон по границам
        return textField
    }()

    private lazy var setStatusButton: UIButton = {
        let button = UIButton()
        button.setTitle("Set status", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 8 // Изменено на 8, чтобы соответствовать идеальному коду
        button.addTarget(self, action: #selector(statusButtonTapped), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .lightGray
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        addSubview(avatarImageView)
        addSubview(fullNameLabel)
        addSubview(statusLabel)
        addSubview(statusTextField)
        addSubview(setStatusButton)
    }

    private func updateStatusLabelText() {
        statusLabel.text = statusTextField.text
        statusTextField.resignFirstResponder() // Скрыть клавиатуру
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateStatusLabelText()
        return true
    }

    @objc private func statusButtonTapped() {
        print(statusTextField.text ?? "No status")
    }

    private func setupConstraints() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusTextField.translatesAutoresizingMaskIntoConstraints = false
        setStatusButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // Констрейнты для avatarImageView
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 128),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),

            // Констрейнты для fullNameLabel
            fullNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            fullNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),

            // Констрейнты для statusLabel
            statusLabel.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor, constant: 16),
            statusLabel.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusLabel.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),

            // Констрейнты для statusTextField
            statusTextField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 16),
            statusTextField.leadingAnchor.constraint(equalTo: fullNameLabel.leadingAnchor),
            statusTextField.trailingAnchor.constraint(equalTo: fullNameLabel.trailingAnchor),
            statusTextField.heightAnchor.constraint(equalToConstant: 32),

            // Констрейнты для setStatusButton
            setStatusButton.topAnchor.constraint(equalTo: statusTextField.bottomAnchor, constant: 16),
            setStatusButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 16),
            setStatusButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -16),
            setStatusButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}
