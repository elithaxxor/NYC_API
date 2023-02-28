//
//  SchoolCoreDataManager.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 2/26/23.
//

import Foundation
import CoreFoundation
import UIKit
import CoreData
import SwiftUI


// NOTE: SEE SchoolDataController for controller properties

@objc(SchoolCoreDataManager)
class SchoolCoreDataManager : NSManagedObject {
	var schoolDB = [Schools]()

}
// NOTE:  SEE GradesDataController for controller properties

@objc(GradesCoreDataManager)
class GradesCoreDataManager : NSManagedObject {
	var gradesDB = [Schools]()

}



extension SchoolCoreDataManager {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<SchoolCoreDataManager> {
		return NSFetchRequest<SchoolCoreDataManager>(entityName: "SchoolCoreDataManager")
	}
	
	@NSManaged public var dbn : String
	@NSManaged public var overview_pararaph : String
	@NSManaged public var school_name : String
	
	
}

// the data mananger for grade is not set up
extension GradesCoreDataManager {
	@nonobjc public class func fetchRequest() -> NSFetchRequest<GradesCoreDataManager> {
		return NSFetchRequest<GradesCoreDataManager>(entityName: "GradesCoreDataManager")
	}
	
	@NSManaged public var grades : String
	@NSManaged public var SCHOOLg : String
	
}
