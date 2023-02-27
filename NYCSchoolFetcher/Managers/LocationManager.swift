//
//  LocationManager.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 2/25/23.
//

import Foundation
import CoreLocation

class locationManager {
	static var shared = locationManager()
	
	func getCoordinates() -> (CLLocationCoordinate2D, CLCircularRegion) {
		
		let coordinates = CLLocationCoordinate2D(
			latitude: 40,
			longitude: 400
		)
		
		let region = CLCircularRegion(
			center: coordinates,
			radius: 100,
			identifier: UUID().uuidString
		)
		region.notifyOnEntry = true
		region.notifyOnExit = false
		
		return(coordinates, region)
	}
}
