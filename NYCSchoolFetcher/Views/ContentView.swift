//
//  ContentView.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: Building header
    var body: some View {
        ZStack {
            //.ignoresSafeArea()
		   
            VStack {
                Text("NYC API Fetcher")
                Spacer(minLength: 0)
            }
            
            VStack(spacing: 200){
            HomeView()}
        }
        
    }
}
// MARK: Segue views
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
