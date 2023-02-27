	//
	//  AnimationSampleView.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/26/23.
	//

import SwiftUI

struct AnimationSampleView: View {
	
	@State private var isAnimated = false
	
	var body: some View {
		notificationView
	}
	
}

struct AnimationSampleView_Previews: PreviewProvider {
	static var previews: some View {
		AnimationSampleView()
	}
	
}



extension AnimationSampleView {
	var notificationView: some View {
		ZStack {
			LinearGradient(colors: [.black, .blue], startPoint: .topTrailing, endPoint: .bottomTrailing)
				.ignoresSafeArea(.all)
			
				// MARK: Builds cells
			
			HStack {
				Text("Subscribe to notifications")
					.bold()
					.opacity(isAnimated ? 1.0 : 0.5)
				
				Spacer()
				
				
				Image(systemName: isAnimated ? "checkmark.circle.fill" : "heart.fill")
					.padding()
					.foregroundColor(isAnimated ? .red : .green)
					.font(.system(size: 24))
				
					.onTapGesture {
						withAnimation(.easeInOut) {
							isAnimated.toggle()
						}
					}
			}
			.padding()
			.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
		}
	}
