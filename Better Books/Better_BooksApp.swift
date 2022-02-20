//
//  Better_BooksApp.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI
import FirebaseCore

@main
struct Better_BooksApp: App {
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Optima-ExtraBlack", size: 32)!]
        
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Optima-ExtraBlack", size: 19)!]

        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
