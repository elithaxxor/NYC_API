//
//  GradesDataController.swift
//  NYCSchoolFetcher
//
//  Created by Adel Al-Aali on 2/24/23.
//


import Foundation
import CoreData

class GradesDataController : ObservableObject {
    
    let container = NSPersistentContainer(name: "GradesDB")
    
    // loads the data
    init(){
        container.loadPersistentStores(completionHandler: { description, error in
            if let error = error {
                print("[-] core data error \(error.localizedDescription)")
            }
            print("grades NSCONTAINER descrption \(description)")
        })
    }
}

