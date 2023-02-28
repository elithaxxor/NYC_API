	//
	//  CloudKitCrud.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/27/23.
	//

import SwiftUI
import CloudKit
import Combine


class CloudKitViewModel : ObservableObject {
	
	
	@Published var text : String = ""
	@Published var cloudData : [CloudKitModel] = []
	
	init(){
		fetchItems()
	}
	
	
	func addButton() {
		guard !text.isEmpty else { return }
		addItem(name: text)
	}
	
	
	
		// creates CK recor and calls saveItem to save to db
	private func addItem(name: String) {
		let newItem = CKRecord(recordType: "Items")
		newItem["name"] = name
		saveItem(record: newItem)
	}
	
	
	private func addOperation(operation: CKDatabaseOperation) {
		CKContainer.default().publicCloudDatabase.add(operation)
	}
	
	 func saveItem(record: CKRecord) {
		CKContainer.default().publicCloudDatabase.save(record) { [weak self] record, error in
			print("[!] Record \(String(describing: record))")
			print("[-] Error \(String(describing: error))")
			
			DispatchQueue.main.async {
				self?.text = " "
			}
		}
	}
	
	
	
	func fetchItems() {
		let predicate = NSPredicate(value: true)
		let query = CKQuery(recordType: "Items", predicate: predicate)
		let queryOperation = CKQueryOperation(query: query)
		var returnedItems : [CloudKitModel] = []
		
		
		
		queryOperation.recordMatchedBlock = { [weak self] id, result in
			switch result {
				case.success(let record):
					guard let name = record["name"] as? String else { return }
					print("[+] Success in matching record block \(record.recordID)")

					// APPENDS DATA TO MODEL
					/// returnedItems.append(name)
					returnedItems.append(CloudKitModel(name: name, record: record))

				case .failure(let error):
					print("[-] Error in matching record block \(error.localizedDescription)")
			}
		}
		
		queryOperation.queryResultBlock = { [weak self ] result in
			print("[+] returned result \(result)")
			DispatchQueue.main.async {
				self?.cloudData = returnedItems
				
			}
		}
		
	
		addOperation(operation: queryOperation)
	}
	
	
	func updateItem(item: CloudKitModel) {
		let record = item.record
		record["name"] = "new name"
		saveItem(record: record)
	}
	
	func deleteItem(indexSet: IndexSet) {
		guard let index = indexSet.first else { return }
		let item = cloudData[index]
		let record = item.record
	}
	

}

