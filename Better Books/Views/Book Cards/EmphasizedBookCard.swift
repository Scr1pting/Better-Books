//
//  EmphasizedBookCard.swift
//  Better Books
//
//  Created by Jonas on 20.02.22.
//

import SwiftUI

struct EmphasizedBookCard: View {
    
    let windowSize: CGSize
    
    var body: some View {
        HStack {
            Image("Scythe-Book-Cover")
                .resizable()
                .scaledToFit()
                .frame(width: abs(windowSize.width / 2 - 25))
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text("Scythe")
                    .font(Font.custom("Optima", size: 25, relativeTo: .title2))
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 2.5)
                
                Text("Neal Shusterman")
                    .font(.subheadline)
                
                Spacer()
            }
            .padding(.leading, 10)
        }
    }
}

struct EmphasizedBookCard_Previews: PreviewProvider {
    static var previews: some View {
        EmphasizedBookCard(windowSize: CGSize(width: 400, height: 700))
    }
}
