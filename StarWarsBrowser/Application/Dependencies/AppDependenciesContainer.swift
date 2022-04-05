//
//  AppDependenciesContainer.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 05.04.2022.
//

import Foundation

final class AppDependenciesContainer {
    
    private let networkService: NetworkService = DefaultNetworkService()
    private let imageLoader: ImageLoaderServiceType = ImageLoaderService()

    func mainSceneDependenciesContainer() -> MainSceneDependenciesContainer {
        return MainSceneDependenciesContainer(networkService: networkService, imageLoaderService: imageLoader)
    }
    
}
