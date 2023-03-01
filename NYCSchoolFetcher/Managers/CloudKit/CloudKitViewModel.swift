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
		
		
		// to store string to database 
		let newItem = CKRecord(recordType: "Items")
		newItem["name"] = name
		saveItem(record: newItem)
		
			// USE CKAssets to get images from system and store images to databse
		guard
			let image = UIImage(named: "image.jpeg"),
			let path = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first?.appendingPathComponent("AppIcon"),
			let data = image.jpegData(compressionQuality: 1.0) else { return }
		
		do {
			try data.write(to: path)
			let asset = CKAsset(fileURL: path)
			newItem["name"] = asset
			saveItem(record: newItem)
		} catch (let error) {
			print("[-] Error in writing iage to file \(error.localizedDescription)")
		}
		
	}
		
		
		func addOperation(operation: CKDatabaseOperation) {
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
			let query = CKQuery(recordType: "image", predicate: predicate)
			let queryOperation = CKQueryOperation(query: query)
			var returnedItems : [CloudKitModel] = []
			
			
			
			
			// APPENDS ATEMTS TO VIEWMODEL
			queryOperation.recordMatchedBlock = { [weak self] id, result in
				switch result {
					case.success(let record):
						guard let name = record["name"] as? String else { return }
						let imageAsset = record["image"] as? CKAsset
						let imageURL = imageAsset?.fileURL
						
						print("[+] Success in matching record block \(record.recordID)")
						
							// APPENDS DATA TO MODEL
							/// returnedItems.append(name)
						returnedItems.append(CloudKitModel(name: name, record: record, imageURL: imageURL, image: imageAsset!))
						
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
			
			CKContainer.default().publicCloudDatabase.delete(withRecordID: record.recordID) { [weak self]
				recordID, error in
				DispatchQueue.main.async {
					self?.cloudData.remove(at: index)
				}
			}
		}
}
	
