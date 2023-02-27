//
//  NotificationManager.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 2/25/23.
//

import Foundation
import SwiftUI
import UserNotifications
import Combine
import CoreLocation

class NotificationManager {
	
	static let shared = NotificationManager()
	
	func requestAuthorization() {
		
		let center = UNUserNotificationCenter.current()
		center.requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
			
			if let error = error {
				print("[-] User notification error  \(error)")
			} else {
				print("[+] User notification success  \(success)")
			}
			
				// Enable or disable features based on the authorization.
			
		}
	}
	
	func scheduleNotification() {
		
		print("[!] Scheduling Notificaition")
		let content = UNMutableNotificationContent()
		content.title = "notifcation 1 "
		content.subtitle = "1"
		content.sound = .default
		content.badge = 1 // sets the home screen icon to "1", indicating a notification
		
			//
			//			// Time interval trigger
			//		let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
			//
			//
		
			// calender interval trigger
		var dateComponents = DateComponents()
		dateComponents.hour = 8
		dateComponents.minute = 0
		dateComponents.weekday = 2
			// calender interval trigger
		let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
		
		
			// location trigger
		
		let (location, region) = LocationManagerSimple.shared.getCoordinates()
		print("notification manager location found [LOCATION] \(location)  [REGION] \(region) ")
		
		
		
		
		let request = UNNotificationRequest (
			identifier: UUID().uuidString,
			content: content,
			trigger: trigger)
		UNUserNotificationCenter.current().add(request)
		print(UNUserNotificationCenter.current())
		
	}
	
}


