	//
	//  CloudKitView.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/27/23.
	//

import SwiftUI
import Combine

struct CloudKitCrud: View {
	
	@StateObject private var vm = CloudKitViewModel()
	
	var body: some View {
		NavigationView {
			VStack {
				header
				textField
				button
				List {
					ForEach(vm.cloudData, id: \.self){
						Text($0.name)
						Text($0.record.description)
					}
				}
				.listStyle(PlainListStyle())
			}
			.padding()
			.navigationBarHidden(true)
		}
		
		
	}
}

struct CloudKitCrud_Previews: PreviewProvider {
	static var previews: some View {
		CloudKitCrud()
	}
}

extension CloudKitCrud {
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
	
	private var button : some View {
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
