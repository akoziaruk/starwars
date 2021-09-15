//
//  MainFlowCoordinator.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import UIKit

class MainFlowCoordinator: FlowCoordinator {
    fileprivate let window: UIWindow
    fileprivate var navigationController: UINavigationController?
    fileprivate let dependencyProvider: MainFlowCoordinatorDependencyProvider
    
    init(window: UIWindow, dependencyProvider: MainFlowCoordinatorDependencyProvider) {
        self.window = window
        self.dependencyProvider = dependencyProvider
    }
    
    func start() {
        navigationController = dependencyProvider.mainNavigationController(navigator: self)
        window.rootViewController = navigationController
    }
}

extension MainFlowCoordinator: MainNavigator {
    func showCategory(for urlString: String) {
        let mainViewController = navigationController?.viewControllers.first as! MainViewController
        let viewModel = dependencyProvider.detailsViewModel(for: urlString)
        mainViewController.detailsViewController.updateWith(viewModel)
    }
}
