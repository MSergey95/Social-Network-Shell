//
//  CustomButton.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/15/24.
//

import UIKit

class CustomButton: UIButton {

    private var action: (() -> Void)?

    // Инициализатор, принимающий параметры title, titleColor и замыкание
    init(title: String, titleColor: UIColor, backgroundColor: UIColor = .systemBlue, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.action = action
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        setupAppearance()
    }

    // Необходимый инициализатор для использования в storyboard'ах
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
    }

    // Метод, вызываемый при нажатии на кнопку
    @objc private func buttonTapped() {
        action?()
    }

    // Метод для настройки внешнего вида кнопки
    private func setupAppearance() {
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
}
