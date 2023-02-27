//
//  CircleButton.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI


// MARK: Parent to create button (see child below)
struct CircleButton: View {
    
    ///.. passes "iconName" as an a modifier argument
    let iconView: String
    var body: some View {
        Image(systemName: iconView)
            .font(.headline)
            .foregroundColor(Color.blue)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(.gray)
            )
            .shadow(radius: 10, x: 0, y: 0)
            .foregroundColor(.blue)
            .padding()
    }
        
}

// MARK: Child modifieres to create additiional button nibs
struct CircleButton_Previews: PreviewProvider {
    static var previews: some View {
        
        Group {
            
            // info button brings up about me
            CircleButton(iconView: "info")
                .previewLayout(.sizeThatFits)
            
            // heart button fetches api information
            CircleButton(iconView: "heart")
                .previewLayout(.sizeThatFits)
        }
        
        
        
        // CircleButton()
    }
}
