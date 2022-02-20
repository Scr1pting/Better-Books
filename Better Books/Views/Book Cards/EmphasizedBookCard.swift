//
//  EmphasizedBookCard.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct EmphasizedBookCard: View {
    
    let book: Book
    let windowSize: CGSize
    
    var body: some View {
        NavigationLink(destination: BookDetailView(book: book)) {
            HStack {
                book.image
                    .resizable()
                    .scaledToFit()
                    .frame(width: abs(windowSize.width / 2 - 25))
                    .cornerRadius(10)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(book.title)
                        .font(Font.custom("Optima", size: 25, relativeTo: .title2))
                        .fontWeight(.bold)
                        .lineSpacing(1.4)
                        .padding(.bottom, 10)
                    
                    Text(book.authors)
                        .font(.subheadline)
                    
                    Text("Recommended")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .italic()
                        .padding(.top, 7.5)
                    
                    Spacer()
                }
                .padding(.leading, 10)
                .padding(.top, 15)
                .multilineTextAlignment(.leading)
                .foregroundColor(.primary)
                
                Spacer()
            }
        }
    }
}
