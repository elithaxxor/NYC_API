	//
	//  BoucingCircle.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/26/23.
	//

import SwiftUI

struct AnimatedShapes: View {
	
	@State private var animate = false
	@State private var animateBtn = false
	
	var body: some View {
		circleAnimate
		buttonAnimate

		Divider()
	}
}
extension AnimatedShapes {
	
	var buttonAnimate: some View {
		VStack {

			Button {
				withAnimation(.easeInOut(duration: 1).repeatCount(10)) {
					animateBtn.toggle()
				}
			}
		label: {
			Text("Activate")
				.bold()
				.frame(width: 200, height: 50)
				.foregroundColor(.cyan)
				.background(LinearGradient(colors: [.purple, .white], startPoint: .bottomTrailing, endPoint: .topLeading))
				.shadow(radius: 3)
				.clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
				.opacity(animateBtn ? 1.0 : 0.7)
				.scaleEffect(animateBtn ? 1.5 : 1.0)
		}
		.padding()
		}
	}
	
	
	var circleAnimate: some View {
		ZStack {
			Circle()
				.frame(width: 100, height: 100)
				.foregroundStyle(.linearGradient(colors : [.green, .white], startPoint: .topTrailing, endPoint:
						.bottomTrailing))
			
				.offset(x: animate ? 30 : 10)
				.scaleEffect(animate ? 2.0 : 1.0)
				// MARK: Gesture Recognization
				.onTapGesture {
					
					withAnimation(.spring()) {
						animate.toggle()
					}
				}
			
		}
	}
}
struct BoucingCircle_Previews: PreviewProvider {
	static var previews: some View {
		AnimatedShapes()
	}
}
