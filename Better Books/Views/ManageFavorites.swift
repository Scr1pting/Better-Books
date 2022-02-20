//
//  ManageFavorites.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct ManageFavorites: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var bookCardsColumns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .top), count: 2)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: bookCardsColumns) {
                ForEach(viewModel.favoriteBooks) { book in
                    DefaultBookCard(book: book)
                }
            }
            .padding(.top, 7.5)
            .padding(.horizontal, 10)
        }
        .navigationTitle("Favorites")
    }
}
