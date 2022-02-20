//
//  Book.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct Book: Identifiable {
    let id: String
    let title: String
    let authors: String
    let description: String
    let image: Image
    let url: URL
}
