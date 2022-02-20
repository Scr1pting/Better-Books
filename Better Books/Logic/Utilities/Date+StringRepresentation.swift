//
//  Date+StringRepresentation.swift
//  Better Books
//
//  Created by Jonas B on 20.02.22.
//

import Foundation

extension Date {
    func stringRepresentation() -> String {
        let dateFormatter: DateFormatter = {
            let formatter = DateFormatter()
            formatter.dateStyle = .short
            return formatter
        }()
        
        return dateFormatter.string(from: self)
    }
}
