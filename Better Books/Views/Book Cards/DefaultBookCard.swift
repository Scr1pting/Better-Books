//
//  DefaultBookCard.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct DefaultBookCard: View {
    var body: some View {
        VStack(alignment: .leading) {
            Image("Scythe-Book-Cover")
                .resizable()
                .scaledToFit()
                .cornerRadius(10)
            
            Text("Scythe")
                .font(Font.custom("Optima", size: 20, relativeTo: .title3))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 5)
                .padding(.bottom, 2.5)
        }
        .padding(.horizontal, 5)
    }
}

struct DefaultBookCard_Previews: PreviewProvider {
    static var previews: some View {
        DefaultBookCard()
    }
}
