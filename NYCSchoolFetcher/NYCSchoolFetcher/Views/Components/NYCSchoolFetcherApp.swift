//
//  NYCSchoolFetcherApp.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/21/23.
//

import SwiftUI
import CoreData
import Combine


@main
struct NYCSchoolFetcherApp: App {

    // gets model and sets to enviroment object for all views
    @StateObject private var schVM = SchoolViewModel()
    @StateObject private var gradesVM = GradesViewModel()
    // Inits the data model
    @StateObject private var schoolDataController = SchoolDataController()
    
    @StateObject private var gradesDataController = GradesDataController()
    
    var body: some Scene {
        WindowGroup {
            
            NavigationView
            {
                /// allows data models access to views
                ContentView()
                    .environmentObject(schVM)
                    .environmentObject(gradesVM)
                    .environment(\.managedObjectContext, schoolDataController.container.viewContext)
                    .environment(\.managedObjectContext, gradesDataController.container.viewContext)

            }
        }
    }
}
