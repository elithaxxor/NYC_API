//
//  CloudKitModel.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 2/27/23.
//

import SwiftUI
import CloudKit
import Combine

	// @StateObject is used to persist state from views

struct CloudKitModel : Hashable {
	let name : String
	let record : CKRecord
	let imageURL : URL?
	let image : CKAsset
	
	
}
