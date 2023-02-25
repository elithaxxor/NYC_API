//
//  FooterView.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI

struct FooterView: View {
    /// @State var isRight: Bool = false
    
    var body: some View {
        Spacer()
        HStack {
            Button {

                APIManager.shared.fetchSchoolData()
            } label: {
                Text("Fetch")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(.horizontal, 20)
                    .background(
                        Color.blue
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    )
            }

        }
        Spacer()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
        
    }
}
