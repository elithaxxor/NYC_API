	//
	//  CloudKitView.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/27/23.
	//

import SwiftUI
import Combine
import Foundation

struct CloudKitView: View {
	
	@StateObject private var vm = CloudKitViewModel()
	
	var body: some View {
		NavigationView {
			ZStack {
				header
				textField
				buttonn
				
//				
//				List {
//					ForEach(vm.cloudData, id: \.self){
//						Text($0.name)
//						Text($0.record.description)
//						
//							// to display image from cloudkit url / CKAsset
//						if let url = vm.cloudData.imageURL,
//						   let data = try? Data(contentsOf: url),
//						   let image = UIImage(data: data) {
//							Image(uiImage: image)
//								.resizable()
//								.frame(width: 50, height: 50)
//						}
//					}
//					.onTapGesture {
//						vm.updateItem(item: vm.cloudData)
//					}
//					
//					
//					.onDelete(perform: vm.deleteItem)
//					.listStyle(PlainListStyle())
//				}
			}
		}
		
		
	}
}

struct CloudKitCrud_Previews: PreviewProvider {
	static var previews: some View {
		CloudKitView()
	}
}

extension CloudKitView {
	private var header : some View {
		Text("CloudKit Crud ")
			.font(.headline)
			.underline()
	}
	
	private var textField: some View {
		TextField("add something here.. ", text: $vm.text)
			.frame(height: 55)
			.padding(.leading)
			.background(Color.gray.opacity(0.3))
			.cornerRadius(10)
	}
	
	private var buttonn : some View {
		Button {
			vm.addButton()
		} label: {
			Text("Add")
				.font(.headline)
				.foregroundColor(.white)
				.frame(height: 55)
				.frame(maxWidth: .infinity)
				.background(Color.blue)
				.cornerRadius(15)
		}
	}
}
