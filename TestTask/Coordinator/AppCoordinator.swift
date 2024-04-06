//
//  AppCoordinator.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

final class AppCoordinator: CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMainVC()
    }
    
    private func showMainVC() {
        let mainViewController = MainViewController()
        let mainViewModel = MainViewModel.init()
        mainViewModel.coordinator = self
        
        mainViewController.viewModel = mainViewModel
        navigationController.navigationBar.isTranslucent = false
        navigationController.pushViewController(mainViewController, animated: true)
    }
}
