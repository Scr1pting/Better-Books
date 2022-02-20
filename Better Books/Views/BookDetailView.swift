//
//  BookDetailView.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct BookDetailView: View {
    
    let book: Book
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Spacer()
                    
                    book.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.top, 10)
                    .padding(.bottom, 15)
                    
                    Spacer()
                }
                
                Text(book.title)
                    .font(Font.custom("Optima", size: 25, relativeTo: .title3))
                    .fontWeight(.black)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 6)
                    .padding(.bottom, 5)
                
                Text(book.authors)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .italic()
                    .padding(.bottom, 15)
                
                Text(book.description.htmlToString())
                    .lineSpacing(1.3)
                    
            }
            .padding(.horizontal)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}
