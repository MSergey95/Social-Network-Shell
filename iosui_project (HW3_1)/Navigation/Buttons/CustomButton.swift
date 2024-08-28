//
//  CustomButton.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/15/24.
//
import UIKit

class CustomButton: UIButton {

    private var action: (() -> Void)?

    // Инициализатор, принимающий параметры title, titleColor, backgroundColor, cornerRadius, shadowColor и замыкание
    init(title: String,
         titleColor: UIColor,
         backgroundColor: UIColor = .systemBlue,
         cornerRadius: CGFloat = 8.0,
         shadowColor: UIColor = .black,
         action: (() -> Void)? = nil) {

        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.setTitleColor(titleColor, for: .normal)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.7
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.action = action
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }

    // Необходимый инициализатор для использования в storyboard'ах
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupAppearance()
        self.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
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
