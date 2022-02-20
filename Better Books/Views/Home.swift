//
//  Home.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var bookCardsColumns: [GridItem] = Array(repeating: .init(.flexible(), alignment: .top), count: 2)
    
    @State var showNewBookSheet = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        if viewModel.recommendedBooks.count > 0 {
                            EmphasizedBookCard(book: viewModel.recommendedBooks.first!, windowSize: geometry.size)
                                .padding(.top, 7.5)
                                .padding(.bottom, 10)
                                .padding(.horizontal)
                        } else {
                            Text("No recommended books found 😭. Check back later of change your book selections")
                                .padding(.top, 7.5)
                                .padding(.horizontal)
                        }
                        
                        if viewModel.recommendedBooks.count > 1 {
                            Text("Other Recommendations")
                                .font(Font.custom("Optima", size: 28, relativeTo: .title2))
                                .fontWeight(.black)
                                .padding(.top, 15)
                                .padding(.horizontal)
                            
                            LazyVGrid(columns: bookCardsColumns) {
                                ForEach(1..<viewModel.recommendedBooks.prefix(4).count) { index in
                                    DefaultBookCard(book: viewModel.recommendedBooks[index])
                                }
                            }
                            .padding(.horizontal, 10)
                        }
                        
                        HStack(alignment: .bottom) {
                            Text("Favorites")
                                .font(Font.custom("Optima", size: 28, relativeTo: .title2))
                                .fontWeight(.black)
                                .padding(.top, 15)
                            
                            Spacer()
                            
                            if viewModel.favoriteBooks.count < 5 {
                                Button(action: {
                                    showNewBookSheet = true
                                }) {
                                    Image(systemName: "plus.circle")
                                        .imageScale(.large)
                                }
                                .padding(.bottom, 5)
                                .sheet(isPresented: $showNewBookSheet) {
                                    NewBook(viewModel: viewModel)
                                }
                            } else {
                                Text("5/5")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .padding(.bottom, 8.5)
                            }
                        }
                        .padding(.horizontal)
                        
                        LazyVGrid(columns: bookCardsColumns) {
                            ForEach(viewModel.favoriteBooks.prefix(3)) { book in
                                DefaultBookCard(book: book)
                            }
                            
                            ManageFavoritesLink(viewModel: viewModel)
                        }
                        .padding(.horizontal, 10)
                    }
                }
                .navigationTitle("Better Books")
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home(viewModel: ViewModel())
    }
}
