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
            
            VStack(alignment: .leading, spacing: 0) {
                Text("Scythe is a great book and this is demo")
                    .font(Font.custom("Optima", size: 25, relativeTo: .title2))
                    .fontWeight(.bold)
                    .lineSpacing(1.4)
                    .padding(.bottom, 10)
                
                Text("Neal Shusterman")
                    .font(.subheadline)
                
                Text("Recommended")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .italic()
                    .padding(.top, 7.5)
                
                Spacer()
            }
            .padding(.vertical, 20)
            .padding(.leading, 10)
        }
    }
}

struct EmphasizedBookCard_Previews: PreviewProvider {
    static var previews: some View {
        EmphasizedBookCard(windowSize: CGSize(width: 400, height: 700))
    }
}
