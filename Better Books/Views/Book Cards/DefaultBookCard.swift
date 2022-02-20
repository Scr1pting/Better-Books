//
//  DefaultBookCard.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct DefaultBookCard: View {
    
    let book: Book
    
    var body: some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            VStack(alignment: .leading) {
                book.image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(10)
                
                Text(book.title)
                    .font(Font.custom("Optima", size: 22, relativeTo: .title3))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 6)
                    .padding(.bottom, 2.5)
            }
            .foregroundColor(.primary)
        }
        .padding(.horizontal, 5)
        .padding(.bottom, 20)
    }
}
