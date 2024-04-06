//
//  CoordinatorProtocol.swift
//  TestTask
//
//  Created by Danil Komarov on 06.04.2024.
//

import UIKit

protocol CoordinatorProtocol {
    
    var parentCoordinator: CoordinatorProtocol? { get set }
    var children: [CoordinatorProtocol] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}

