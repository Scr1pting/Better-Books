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
                .cornerRadius(15)
            
            Text("Scythe")
                .font(Font.custom("Optima", size: 22, relativeTo: .title3))
                .fontWeight(.bold)
                .multilineTextAlignment(.leading)
                .padding(.top, 6)
                .padding(.bottom, 2.5)
        }
        .padding(.horizontal, 5)
        .padding(.bottom, 20)
    }
}

struct DefaultBookCard_Previews: PreviewProvider {
    static var previews: some View {
        DefaultBookCard()
    }
}
