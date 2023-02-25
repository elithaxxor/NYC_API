//
//  HomeViewModel.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/22/23.
//

import Foundation
import Combine
import CoreData
import SwiftUI

// calls api manager for fetch

class SchoolViewModel : ObservableObject, Identifiable {
    
    @Published var schools : [Schools] = []
    
    

    private let apiService = APIManager()
    private var cancellabels = Set<AnyCancellable>()
    
    // TO set up coredb
    @Environment(\.managedObjectContext) var schoolMoc
    @FetchRequest (sortDescriptors: []) var schoolsDB : FetchedResults<SchoolDB> // grades\ is from CoreData
    
    
    
    /// checks APIManagers subscibers for changes
    func addSubscribers() {
        
        let data = SchoolDB(context: schoolMoc)
        apiService.$allSchools
            .sink{ [weak self] schools in
                self?.schools = schools
                let school = self?.schools
                print("schoo")

                print(" [id]: \n [School] \(school)" )
            }
        
    }
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.addSubscribers()
        }
    }
    
}
