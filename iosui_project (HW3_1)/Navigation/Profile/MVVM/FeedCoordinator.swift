//
//  FeedCoordinator.swift
//  Navigation
//
//  Created by Сергей Минеев on 8/16/24.
//

import Foundation
import UIKit

final class FeedCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let feedVC = FeedViewController()
        feedVC.coordinator = self
        navigationController.pushViewController(feedVC, animated: false)
    }
}
