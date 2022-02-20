//
//  MoreBooks.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct ManageFavoritesLink: View {
    var body: some View {
        NavigationLink(destination: Text("Hello World")) {
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
    }
}

struct MoreBooks_Previews: PreviewProvider {
    static var previews: some View {
        ManageFavoritesLink()
    }
}
