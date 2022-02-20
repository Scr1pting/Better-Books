//
//  Collection+Contains.swift
//  Better Books
//
//  Created by Jonas B on 20.02.22.
//

import Foundation

extension Collection where Element: Identifiable {
    func contains(_ element: Element) -> Bool {
        for item in self {
            if item.id == element.id {
                return true
            }
        }
        
        return false
    }
}
