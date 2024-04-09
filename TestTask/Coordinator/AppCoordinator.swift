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
        navigationController.pushViewController(mainViewController, animated: true)
    }
    
    func showWinnerAlert(restart: @escaping () -> Void) {
        let alertController = UIAlertController(title: "Игра окончена", message: nil, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Начать заново", style: .default) { [weak self] _ in
            guard let self = self else { return }
            restart()
        }
        alertController.addAction(restartAction)
        navigationController.present(alertController, animated: true, completion: nil)
    }
}
