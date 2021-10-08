//
//  MainViewController.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 9/13/21.
//

import UIKit

class MainViewController: UIViewController {
    var categoriesViewController: CategoriesViewController!
    var detailsViewController: DetailsViewController!
    @IBOutlet weak var paralaxView: StarsParalaxView!
    @IBOutlet weak var logoView: UIView!

    init(_ categoriesViewController: CategoriesViewController,
         _ detailsViewController: DetailsViewController) {
        self.categoriesViewController = categoriesViewController
        self.detailsViewController = detailsViewController
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        add(viewController: categoriesViewController)
        add(viewController: detailsViewController)
        addConstraints()
    }
    
    private func addConstraints() {
        categoriesViewController.view.translatesAutoresizingMaskIntoConstraints = false
        detailsViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoriesViewController.view.heightAnchor.constraint(equalToConstant: 130),
            categoriesViewController.view.topAnchor.constraint(equalTo: logoView.bottomAnchor),
            categoriesViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            categoriesViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            detailsViewController.view.topAnchor.constraint(equalTo: categoriesViewController.view.bottomAnchor),
            detailsViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            detailsViewController.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            detailsViewController.view.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    private func setupView() {
    }
    
}

fileprivate extension MainViewController {
    func add(viewController: UIViewController) {
        addChild(viewController)
        view.addSubview(viewController.view)
        viewController.didMove(toParent: self)
    }
}
