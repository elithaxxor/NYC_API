//
//  GradesViewModel.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/22/23.
//

import Foundation
import Combine
import SwiftUI

// calls api manager for fetch

class GradesViewModel : ObservableObject, Identifiable {
    
    
    @Published var grades : [Grades] = []
    
    
    private let apiService = APIManager()
    private var cancellabels = Set<AnyCancellable>()
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest (sortDescriptors: []) var gradesdb : FetchedResults<GradesDB> // grades\ is from CoreData
    
    
    
    
    /// checks APIManagers subscibers for changes
    func addSubscribers() {
        apiService.$allGrades
            .sink{ [weak self] grades in
                self?.grades = grades
                //let grade = GradesDB(context: moc)
               // grade. = grades
            }
    }
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.addSubscribers()
        }
    }
    
}
