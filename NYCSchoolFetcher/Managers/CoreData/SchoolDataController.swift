	//
	//  SchoolDataController.swift
	//  NYCSchoolFetcher
	//
	//  Created by Adel Al-Aali on 2/24/23.
	//

import Foundation
import CoreData
import UIKit

class SchoolDataController : ObservableObject {
	
	var data : [SchoolDB]?
	let container = NSPersistentContainer(name: "SchoolDB")
	
		// FIXME: This Creates thread lock, because container is persisted via init() method
	lazy var context = (UIApplication.shared.delegate as! NSPersistentContainer).viewContext
	
	
		// loads the data
	init(){
		container.loadPersistentStores(completionHandler: { description, error in
			if let error = error {
				print("[-] core data error \(error.localizedDescription)")
			}
			print("schools NSCONTAINER descrption \(description)")
			
		})
	}
	
	func fechCoreData() {
		print("[!] Fetching  core data")

		do {
			self.data = try container.viewContext.fetch(SchoolDB.fetchRequest())
			print("[+] Successfully fethed core data")
		}
		catch (let err){
			print("[-] Error in core data \(err.localizedDescription)")
		}
	}
	
		// Use UI to get context from user (add button)
	func addCoreData() {
		print("[!] adding to core data")

		let newData = SchoolDB(context: context)
		
			// MARK: get input frm user
		newData.dbn = "samble db DBN"
		newData.school_name = "samble db samble db school_name"
		newData.overview_paragraph = "samble db samble db overview_paragraph"
		
		
		do {
			try self.context.save()
			print("[+] Succesfully saved new data to CoreData DB")
		} catch (let err){
			print("[!] Error in saving new data to CoreData DB")
			print("\(err.localizedDescription)")
		}
		self.fechCoreData()
	}
	
	// Link to UI to remove data
	func removeCoreData() {
		print("[!] removing from core data")

		// MARK: Edit the remove data source, this is a sample
		var remove = (self.data?.remove(at: 3))!
		self.context.delete(remove)
		
		do {
			try self.context.save()
			print("[+] Succesfully saved new data to CoreData DB")
		} catch (let err){
			print("[!] Error in saving new data to CoreData DB")
			print("\(err.localizedDescription)")
		}
		self.fechCoreData()
	}
}
