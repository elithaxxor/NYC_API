//
//  HomeViewModel.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/22/23.
//

import Foundation
import Combine

// calls api manager for fetch

class SchoolViewModel : ObservableObject, Identifiable {
    
    @Published var schools : [Schools] = []
    
    
    
    private let apiService = APIManager()
    private var cancellabels = Set<AnyCancellable>()
    
    
    /// checks APIManagers subscibers for changes
    func addSubscribers() {
        apiService.$allSchools
            .sink{ [weak self] schools in
                self?.schools = schools
            }
        
    }
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            self?.addSubscribers()
        }
    }
    
}
