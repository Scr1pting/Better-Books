//
//  ContentView.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        Home(viewModel: viewModel)
            .onAppear {
                viewModel.fetchFavoriteBooks()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
