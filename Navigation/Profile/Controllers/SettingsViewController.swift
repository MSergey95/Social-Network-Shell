//
//  SettingsViewController.swift
//  Navigation
//
//  Created by Сергей Минеев on 12/17/24.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {

    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Имя пользователя"
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    private let userNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Введите имя пользователя"
        textField.borderStyle = .roundedRect
        return textField
    }()

    private let themeSwitch: UISwitch = {
        let themeSwitch = UISwitch()
        themeSwitch.isOn = UITraitCollection.current.userInterfaceStyle == .dark
        return themeSwitch
    }()

    private let themeLabel: UILabel = {
        let label = UILabel()
        label.text = "Темная тема"
        return label
    }()

    private let logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выйти из профиля", for: .normal)
        button.setTitleColor(.red, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Настройки"
        setupUI()
        loadSavedData()
    }

    private func setupUI() {
        let stackView = UIStackView(arrangedSubviews: [
            userNameLabel, userNameTextField,
            themeLabel, themeSwitch,
            logoutButton
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])

        themeSwitch.addTarget(self, action: #selector(didChangeTheme), for: .valueChanged)
        logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    }

    private func loadSavedData() {
        // Загрузка сохраненного имени пользователя
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            userNameTextField.text = savedName
        }
    }

    @objc private func didChangeTheme(_ sender: UISwitch) {
        // Переключение темы
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        windowScene?.windows.forEach { window in
            window.overrideUserInterfaceStyle = sender.isOn ? .dark : .light
        }
    }

    @objc private func logoutTapped() {
        // Выход из профиля
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        navigationController?.popToRootViewController(animated: true)
    }
}
