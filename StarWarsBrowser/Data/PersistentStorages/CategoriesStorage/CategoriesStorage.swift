//
//  CategoriesStorage.swift
//  StarWarsBrowser
//
//  Created by Alexander Koziaruk on 04.04.2022.
//

import Foundation
import Combine

protocol CategoriesStorage {
    func requestAll() -> AnyPublisher<CategoriesDTO, Error>
    func save(_ categories: CategoriesDTO)
}
