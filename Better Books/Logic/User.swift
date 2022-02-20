//
//  User.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import Foundation

struct User: Identifiable {
    let id: String
    let favoriteBookIds: [String]
}
