//
//  Home.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct Home: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var bookCardsColumns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    @State var showNewBookSheet = false
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ScrollView {
                    VStack(alignment: .leading) {
                        EmphasizedBookCard(windowSize: geometry.size)
                            .padding(.top, 7.5)
                            .padding(.horizontal)
                        
                        HStack(alignment: .bottom) {
                            Text("Favorites")
                                .font(Font.custom("Optima", size: 28, relativeTo: .title2))
                                .fontWeight(.black)
                                .padding(.top, 30)
                            
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
                                    NewBook()
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
                            DefaultBookCard()
                            DefaultBookCard()
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
