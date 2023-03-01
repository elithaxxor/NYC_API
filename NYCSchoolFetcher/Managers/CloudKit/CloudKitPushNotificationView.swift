	//
	//  CloudKitPushNotification.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/28/23.
	//

import SwiftUI
import Combine
import CloudKit

class CloudKitPushNotification : ObservableObject {
	
	
	func requestPushAuthorization() {
		print("[!] Requesting Push Authorization")
		
			// create options
		let options: UNAuthorizationOptions = [.alert, .sound, .badge]
		
			// send request authorization to notification center
		UNUserNotificationCenter.current().requestAuthorization(options: options) { [weak self] success, error in
			if let error = error {
				print("[-] Error in requesting user notifications \(error.localizedDescription)")
			} else if success {
				print("[+] Notification success! \(success)")
				DispatchQueue.main.async {
					UIApplication.shared.registerForRemoteNotifications() // sends msg to serer 
				}
			}
			else {
				print("[-] Notifications Failure ")
			}
		}
	}
	
	func subscribeToNotifications() {
		print("[!] Subscribing to Push Authorization")
		
			// NSPredicate allows filitirng through data, this is the basic function
		let predicate = NSPredicate(value : true)
		
			// use this to manage and determinee subscription
		let subscription = CKQuerySubscription(recordType: "Items", predicate: predicate, subscriptionID: "added_to_db", options: .firesOnRecordUpdate)
		
			// creates notification body
		let notification = CKSubscription.NotificationInfo()
		notification.title = "There is new item "
		notification.alertBody = "check your subscriptions"
		notification.soundName = "default"
		subscription.notificationInfo = notification
		
		CKContainer.default().publicCloudDatabase.save(subscription) { returnedSubscription, returnedError in
			if let error = returnedError {
				print("[-] Error rin creating subscirption in icloud \(error.localizedDescription)")
			} else {
				print("[+] Succesfully subscriped to subscription")
			}
		}
		print("[+] Subscription To Push Notification Created \(subscription)")
	}
	
	func unsubscribeNotifications() {
		CKContainer.default().publicCloudDatabase.delete(withSubscriptionID: "added_to_db") {
			returnID, returnedError in
			if let error = returnedError {
				print("[-] error in unsubscribing from notifications \(error.localizedDescription)")
			} else {
				print("[+] successfully unsubscribed from notification subscription")
			}
		}
	}
}


struct CloudKitPushNotificationView: View {
	
	@StateObject private var vm = CloudKitPushNotification()
	var body: some View {
		VStack(spacing: 30) {
			Button("request push authorizaton") {
				vm.requestPushAuthorization()
			}
			Button("subscribe to authorizations") {
				vm.subscribeToNotifications()
			}
			Button("unsubscribe from notifiations"){
				vm.unsubscribeNotifications()
				
			}
		}
	}
}

struct CloudKitPushNotification_Previews: PreviewProvider {
	static var previews: some View {
		CloudKitPushNotificationView()
	}
}
