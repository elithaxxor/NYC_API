//
//  SquareButton.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI


// MARK: View to create back button and to fetch data
///.. note to self.... SwiftUI is whitespace sensitive.
///
struct SquareButton: View {
    
    
    var iconView: String
    var body: some View {
        Image(systemName: iconView)
            .font(.headline)
            .foregroundColor(.gray)
            .foregroundColor(Color.blue)
            .frame(width: 300, height: 50)
            .background(
                Rectangle()
                    .foregroundColor(.gray)
            )

            .shadow(radius: 10, x: 0, y: 0)
            .foregroundColor(.blue)
            .padding()
        
    }
}

struct SquareButton_Previews: PreviewProvider {
    
    // For to revert to the back view
    
    
    static var previews: some View {
        Group {
            SquareButton(iconView: "chevron.left")
                //.previewLayout(.sizeThatFits)
                .previewLayout(.fixed(width: 375, height: 80))
            SquareButton(iconView: "chevron.right")
               // .previewLayout(.sizeThatFits)
                .previewLayout(.fixed(width: 375, height: 80))
        }
        
        
    }
    
}
