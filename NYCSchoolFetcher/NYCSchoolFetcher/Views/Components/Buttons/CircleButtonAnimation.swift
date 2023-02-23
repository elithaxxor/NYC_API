//
//  CircleButtonAnimation.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import Foundation
import SwiftUI


struct CircleButtonAnimationView: View {
   
    
    //@State var animate : Bool = false
    @Binding var animate : Bool
    
    
    var body: some View {
        Circle()
            .stroke(lineWidth: 5.0)
        
            
            .scale(animate ? 1.0 : 0.0) // movement
            .opacity(animate ? 0.0 : 1.0) // fade
            .animation(animate ? Animation.easeOut(duration: 1.0) : .none) // movement speed
            .onAppear{
                animate.toggle()
            }
    }
}

struct CircleButtonAnimationView_Previews: PreviewProvider {
    static var previews: some View {
        CircleButtonAnimationView(animate: .constant(true))
            .frame(width: 100, height: 100)
            .foregroundColor(.red)
    }
}
