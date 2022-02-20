//
//  MoreBooks.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct ManageFavoritesLink: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            NavigationLink(destination: ManageFavorites(viewModel: viewModel)) {
                Circle()
                    .foregroundColor(.accentColor)
                    .opacity(0.3)
                    .overlay(
                        Image(systemName: "ellipsis")
                            .font(.system(size: 40))
                            .foregroundColor(Color(.systemBackground))
                    )
                    .frame(width: 95, height: 95)
            }
            .padding(.bottom, 30)
            
            Spacer()
        }
    }
}
