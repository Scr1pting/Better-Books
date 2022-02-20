//
//  Better_BooksApp.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

@main
struct Better_BooksApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 32)!]
        
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Georgia-Bold", size: 19)!]

    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
