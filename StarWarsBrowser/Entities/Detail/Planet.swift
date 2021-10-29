//
//  Planet.swift
//  StarWarsBrowser
//
//  Created by Olexander Koziaruk on 10/19/21.
//

import Foundation

struct Planet: Detail {
    var type: Category.T { .planet }
    var imagePath: String { "planets/" + name.snakeCase }
    let name: String
}
