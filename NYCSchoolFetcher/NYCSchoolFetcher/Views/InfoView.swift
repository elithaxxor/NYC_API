//
//  InfoView.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/24/23.
//

import SwiftUI
import Combine
struct InfoView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        VStack{
            Text("sample assignment")
      
        ZStack  (alignment: .topLeading) {
            Color.purple
                .edgesIgnoringSafeArea(.all)
            Button(action: {
                print("[!] leaving info section")
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .padding(20)
            })
        }
        }
        
        // MARK: Creates X on top left of popover
        // TODO: Fix bug-- UI now showing 'x'
 
        Text("copy left @adel alaali -- All Wrongs Reserved!!!!")
        
    }
    
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
