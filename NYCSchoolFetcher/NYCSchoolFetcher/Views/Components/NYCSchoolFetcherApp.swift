//
//  NYCSchoolFetcherApp.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI

@main
struct NYCSchoolFetcherApp: App {

    // gets model and sets to enviroment object for all views
    @StateObject private var vm = SchoolViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            NavigationView
            {
                ContentView()
                    
            }
            .environmentObject(vm)
        }
    }
}
