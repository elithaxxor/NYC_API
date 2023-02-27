	//
	//  InfoView.swift
	//  NYCSchoolFetcher
	//
	//  Created by Adel Al-Aali on 2/24/23.
	//

import SwiftUI
import Combine
struct InfoView: View {
	
	@Environment(\.presentationMode) var presentationMode
	
	var notification = AnimationSampleView()
	var body: some View {
		
		VStack{
			Text("sample assignment")
			
			ZStack  (alignment: .topLeading) {
				
				LinearGradient(colors: [.black, .blue], startPoint: .topTrailing, endPoint: .bottomTrailing)
					.ignoresSafeArea(.all)
				
				
				Button(action: {
					print("[!] leaving info section")
					notification.notificationView
					
					presentationMode.wrappedValue.dismiss()
				}, label: {
					Image(systemName: "heart.fill")
						.foregroundColor(.white)
						.font(.largeTitle)
						.padding(20)
				})
	
			}
			HStack(alignment: .center) {

				ZStack(alignment: .topTrailing) {
					
					AnimatedShapes().buttonAnimate
					
				}
			}
		}
		
		
		HStack{
		}
	}
	
		// MARK: Creates X on top left of popover
		// TODO: Fix bug-- UI now showing 'x'
	
	
}



struct InfoView_Previews: PreviewProvider {
	static var previews: some View {
		InfoView()
	}
}
