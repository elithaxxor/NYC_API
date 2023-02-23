//
//  GradesViewModel.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/22/23.
//

import Foundation
import Combine


// calls api manager for fetch

class GradesViewModel : ObservableObject, Identifiable {
    
    
    @Published var grades : [Grades] = []
    
    
    private let apiService = APIManager()
    private var cancellabels = Set<AnyCancellable>()
    
    
    /// checks APIManagers subscibers for changes
    func addSubscribers() {
        apiService.$allGrades
            .sink{ [weak self] grades in
                self?.grades = grades
            }
    }
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.addSubscribers()
        }
    }
    
}
