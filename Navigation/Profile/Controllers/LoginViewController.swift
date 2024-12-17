import UIKit
import FirebaseAuth

final class LoginViewController: UIViewController {

    // MARK: - Properties
    var onLoginSuccess: (() -> Void)? // Колбэк при успешном входе

    // MARK: - UI Components
    private let loginScrollView = UIScrollView()
    private let contentView = UIView()

    private let vkLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "vkLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let loginField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter email"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        return textField
    }()

    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()

    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.isEnabled = false
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.isHidden = true
        button.setTitleColor(.systemBlue, for: .normal)
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupActions()
    }

    // MARK: - UI Setup
    private func setupUI() {
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(contentView)
        [vkLogo, loginField, passwordField, loginButton, signUpButton].forEach { contentView.addSubview($0) }

        loginScrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        vkLogo.translatesAutoresizingMaskIntoConstraints = false
        loginField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        signUpButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            loginScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            loginScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),

            vkLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            vkLogo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vkLogo.heightAnchor.constraint(equalToConstant: 100),
            vkLogo.widthAnchor.constraint(equalToConstant: 100),

            loginField.topAnchor.constraint(equalTo: vkLogo.bottomAnchor, constant: 40),
            loginField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            loginField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            loginField.heightAnchor.constraint(equalToConstant: 40),

            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 20),
            passwordField.leadingAnchor.constraint(equalTo: loginField.leadingAnchor),
            passwordField.trailingAnchor.constraint(equalTo: loginField.trailingAnchor),
            passwordField.heightAnchor.constraint(equalToConstant: 40),

            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30),
            loginButton.leadingAnchor.constraint(equalTo: passwordField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 50),

            signUpButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            signUpButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
        ])
    }

    private func setupActions() {
        loginField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldsDidChange), for: .editingChanged)
        loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
    }

    // MARK: - Actions
    @objc private func textFieldsDidChange() {
        let isEnabled = !(loginField.text?.isEmpty ?? true) && !(passwordField.text?.isEmpty ?? true)
        loginButton.isEnabled = isEnabled
        loginButton.alpha = isEnabled ? 1.0 : 0.5
    }

    @objc private func handleLogin() {
        guard let email = loginField.text, let password = passwordField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                self?.showAlert(title: "Login Error", message: error.localizedDescription)
                self?.signUpButton.isHidden = false
            } else {
                self?.onLoginSuccess?()
            }
        }
    }

    @objc private func handleSignUp() {
        guard let email = loginField.text, let password = passwordField.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] _, error in
            if let error = error {
                self?.showAlert(title: "Sign Up Error", message: error.localizedDescription)
            } else {
                self?.onLoginSuccess?()
            }
        }
    }

    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
