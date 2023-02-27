	//
	//  CloudKitManager.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/26/23.
	//

import SwiftUI
import CloudKit

class CloudKitManager : ObservableObject {
	@Published var isSignedIn: Bool = false
	@Published var error : String = ""
	
	init() {
		getIcloudStatus()
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
			Text("Is Signed in? \(vm.getIcloudStatus.description)")
			Text("[error] \(vm.error)")
			
		}
	}
}

struct CloudKitManager_Previews: PreviewProvider {
	static var previews: some View {
		CloudKitManagerView()
		
	}
}
