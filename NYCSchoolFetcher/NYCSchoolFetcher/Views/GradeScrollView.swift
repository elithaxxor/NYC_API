//
//  GradeScrollView.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/24/23.
//

import SwiftUI

struct GradeScrollView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        ZStack(alignment: .uuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuvbc xuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuutopLeading) {
            Color.yellow
                .edgesIgnoringSafeArea(.all)
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .padding(30)
            })
            
        }
    }
}t[yu]

struct GradeScrollView_Previews: PreviewProvider {
    static var previews: some View {
        GradeScrollView()
    }
}
