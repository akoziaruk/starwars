//
//  CategoriesViewModel.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 8/30/21.
//

import Combine
import Foundation

class CategoriesViewModel: CategoriesViewModelType {
    private let useCase: MainUseCaseType
    private weak var navigator: MainNavigator?
    private var subscriptions = Set<AnyCancellable>()
    private var selectedCategory = CategoryType.film
    
    init(useCase: MainUseCaseType, navigator: MainNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }

    func transform(input: CategoriesViewModelInput) -> CategoriesViewModelOutput {
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
        
        let categories = input.load
            .flatMapLatest({ [unowned self] in self.useCase.loadCategories() })
            .map({ result -> CategoriesLoadingState in
                switch result {
                case .success(let categories) where categories.items.isEmpty: return .noResult
                case .success(let categories): return .success(self.viewModels(from: categories.items))
                case .failure(let error): return .failure(error)
                }
            })
            .eraseToAnyPublisher()
        
        categories
            .first()
            .sink(receiveValue: { [unowned self] state in
                if case .success(let items) = state,
                   let item = items.first {
                    self.didSelectedItem(with: item.type, url: item.url)
                }
            })
            .store(in: &subscriptions)
            
        input.select
            .sink(receiveValue: { [unowned self] item in
                self.didSelectedItem(with: item.type, url: item.url)
            })
            .store(in: &subscriptions)
        
        let initialState: CategoriesViewModelOutput = .just(.idle)

        return Publishers.Merge(initialState, categories).removeDuplicates().eraseToAnyPublisher()
    }
    
    private func didSelectedItem(with type: CategoryType, url: URL) {
        self.selectedCategory = type
        self.navigator?.showCategory(for: type, url: url)
    }
    
    private func viewModels(from categories: [Category]) -> [CategoryViewModel] {
        return categories.compactMap { CategoryViewModel($0, selected: selectedCategory == $0.type) }
    }
    
}