//
//  ContentView.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                Text("Hello, world!")
                    .padding()
            }
            .navigationTitle("Better Books")
            .toolbar {
                ToolbarItem {
                    Button("Test", action: {})
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
