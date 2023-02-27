//
//  AssortedButtons.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/23/23.
//

import SwiftUI

struct AssortedButtons: View {
    
    @State var title : String = "hello world"
    var body: some View {
        VStack(spacing: 20) {
            
            Text(title)
                .accentColor(.red)
            
            
            Button("press me #1") {
                self.title = "button 1 pressed "
            }
            .accentColor(.cyan)
            
            
            
            Button {
                self.title = "button 2 pressed"
            } label: {
                Text("press me #2")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.red)
                    .padding()
                    .background(
                        Color.blue
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    )
            }
            
            Button(action: {
                self.title = "button  3pressed"
            }, label: {
                Circle()
                    .fill(.yellow)
                    .frame(width: 70, height: 70)
                    .overlay(
                    Image(systemName: "heart.fill")
                        .font(.largeTitle)
                        .foregroundColor(.blue  )
                    
                    )
            }
                    
            )
        }
    }
}

struct AssortedButtons_Previews: PreviewProvider {
    static var previews: some View {
        AssortedButtons()
    }
}
