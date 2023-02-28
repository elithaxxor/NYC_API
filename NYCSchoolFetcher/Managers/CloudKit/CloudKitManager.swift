	//
	//  CloudKitManager.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/26/23.
	//

import SwiftUI
import CloudKit
import Combine

class CloudKitManager : ObservableObject {
	@Published var isSignedIn: Bool = false
	@Published var error : String = ""
	@Published var userName : String = ""
	@Published var permissionStatus : Bool = false
	init() {
		getIcloudStatus()
		requestPermission()
	}
	
	func requestPermission() {
		CKContainer.default().requestApplicationPermission([.userDiscoverability]) {
			[weak self] status, error in
			DispatchQueue.main.async {
				if status == .granted {
					self?.permissionStatus = true
				}
			}
		}
	}
	
		// use the .discoverUserIdentity to parse differnt icloud ids (name, lastname etc)
	func fetchIcloudUserID() {
		CKContainer.default().fetchUserRecordID {
			[weak self] returnedID, error in
			
			if let id = returnedID {
				self?.discoverIcloudUser(id: id) // uses helper function to fetch icloud user
				
			}
		}
	}
	// helper function to fetch ID (helper for fetchIcloudUserID)
	func discoverIcloudUser(id: CKRecord.ID) {
		CKContainer.default().discoverUserIdentity(withUserRecordID: id) { [weak self] returnedID, error in
			if let name = returnedID?.nameComponents?.givenName {
				self?.userName = name
			}
			
		}
	}
	
	
	

	private func getIcloudStatus() {
		CKContainer.default().accountStatus{ [weak self] status, error in
			DispatchQueue.main.async {
				switch status {
					case .available:
						self?.isSignedIn = true
					case .couldNotDetermine:
						self?.error = CloudKitError.iCloudaAccountNotFound.rawValue
					case .restricted:
						self?.error = CloudKitError.icloudAccountNotDetermined.rawValue
					case .noAccount:
						self?.error = CloudKitError.icloudAccountRestricted.rawValue
					case .temporarilyUnavailable:
						self?.error = CloudKitError.icloudAccountUnknown.rawValue
						
					default:
						self?.error = CloudKitError.icloudAccountTemporarilyUnavailable.rawValue
						
				}
			}
		}
	}
}
	// error handling
enum CloudKitError : String, LocalizedError {
	case iCloudaAccountNotFound
	case icloudAccountNotDetermined
	case icloudAccountRestricted
	case icloudAccountUnknown
	case icloudAccountTemporarilyUnavailable
	
}
struct CloudKitManagerView: View {
	
	@StateObject private var vm = CloudKitManager()
	var body: some View {
		VStack {
		//	Text("Is Signed in? \(vm.getIcloudStatus.description)")
			Text("[name] \(vm.userName)")
			Text("[permissions] \(vm.permissionStatus.description)")
			Text("[error] \(vm.error)")
			
			
		}
	}
}

struct CloudKitManager_Previews: PreviewProvider {
	static var previews: some View {
		CloudKitManagerView()
		
	}
}
