	//
	//  LocationNetworkManager.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/26/23.
	//


import Foundation
import CoreLocation
import MapKit


internal class LocationNetworkManager {
	
	
	var routeData : Route?
	var routeCoordinates : [CLLocation] = []
	var routeOverlay  : MKOverlay?
	
	func getJson() -> Data? {
		let path = Bundle.main.path(forResource: "data", ofType: "json")!
		do {
			let data = try String(contentsOfFile: path).data(using: .utf8)
			
			print("[+] Json sucessfully received")
			return data
		} catch  {
			print("[-] Error, unable to get JSON ")
		}
		
		return nil
	}
	
	func parseJson(jsonData: Data) {
		do {
			routeData = try JSONDecoder().decode(Route.self, from: jsonData )
			
			for feature in routeData?.features ?? [] {
				let loc = CLLocation (
					latitude: feature.geometry.coordinates[1],
					longitude:  feature.geometry.coordinates[0]
				)
				routeCoordinates.append(loc)
			}
		} catch {
			print("error in func parseJson --> feature coordinates ")
		}
	}
}
