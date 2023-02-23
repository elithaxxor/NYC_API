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
            SquareButton(iconView: "right")
        }
        Spacer()
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
        
    }
}
