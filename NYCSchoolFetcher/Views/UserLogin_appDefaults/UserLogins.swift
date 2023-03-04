	//
	//  UserLogins.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 3/3/23.
	//

import SwiftUI

struct UserLogins: View {
	
	// storage
	@AppStorage("signed_in") var isSignedIn : Bool = false
	@AppStorage("age") var currentAge: Int?
	@AppStorage("gender") var currentGender : String?
	@AppStorage("email") var currentEmail : String?
	@AppStorage("pass") var currentPass : String?

	
	// alerts / ui logic
	@State var alertTitle: String = ""
	@State var showAlert : Bool = false
	
	// uesr input
	@State var email : String = ""
	@State var password : String = ""
	@State var viewSequence : Int  = 0
	@State var age : Double  = 50
	@State var gender : String = ""
	
	
	
	let transition : AnyTransition =
		.asymmetric(
			insertion: .move(edge: .trailing),
			removal: .move(edge: .leading))
	
	
	var body: some View {
		ZStack {
			
			
			ZStack { // allows body change
				RoundedRectangle(cornerRadius: 25.0)
					.foregroundColor(.blue)
				LinearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomTrailing)
				
				
				switch viewSequence {
					case 0: emailView
							.transition(transition)
					case 1: passwordView
							.transition(transition)
					case 2: genderView
							.transition(transition)
					case 3: ageView
							.transition(transition)
						
					default:
						RoundedRectangle(cornerRadius: 25.0)
							.foregroundColor(.blue)
				}
			}
			VStack { // bottom view
				
				Spacer()
				bottomBtn
			}
			.padding(30)
			.alert(isPresented: $showAlert, content: {
				return Alert(title: Text(alertTitle))
			})
		}
		
	}
	
}

struct UserLogins_Previews: PreviewProvider {
	static var previews: some View {
		UserLogins()
	}
}

extension UserLogins {
	
	private var bottomBtn : some View{
		
		Text(
			viewSequence == 0 ? "email" :
				viewSequence == 1 ? "password" :
				viewSequence == 2 ? "gender" :
				viewSequence == 3 ? "age" :
				"next"
		)
		.font(.headline)
			//.frame(minWidth: .infinity, minHeight: .infinity)
		.frame(width: 200, height: 50)
		.foregroundColor(.green)
		.frame(height: 55)
		.background(Color.white)
		.cornerRadius(10)
		.onTapGesture {
			
			
			handleBottomBtn()
			
		}
	}
	
	
	private var emailView: some View {
		VStack(spacing: 50 ){
			Image(systemName: "heart.text.square.fill")
				.resizable()
				.scaledToFill()
				.frame(width: 200, height: 200)
				.foregroundColor(.white)
			
			Text("welcome")
				.font(.largeTitle)
				.fontWeight(.semibold)
			
			TextField("email..", text: $email)
				.foregroundColor(.black)
				.fontWeight(.semibold)
				.overlay(
					Capsule(style: .continuous)
						.frame(height: 50)
						.fontWeight(.semibold)
						.foregroundColor(.white)
					
					, alignment: .bottom
				)
			
			
			
			
			
			Text("welcome to the app, you are signing in ")
				.fontWeight(.medium)
				.foregroundColor(.black)
				.overlay(
					Capsule(
						style: .continuous)
					.foregroundColor(.white)
					.fontWeight(.thin)
				)
			
		}
		.multilineTextAlignment(.center)
		.padding(30)
		
	}
	
	private var passwordView : some View {
		VStack {
			
			Text("enter your password ")
				.fontWeight(.medium)
				.foregroundColor(.black)
				.overlay(
					Capsule(
						style: .continuous)
					.foregroundColor(.white)
					.fontWeight(.thin)
				)
			
			TextField("password..", text: $password)
				.font(.headline)
				.fontWeight(.semibold)
				.frame(height: 60)
				.padding(.horizontal)
				.cornerRadius(20)
			
		}
		
		.padding(30)
		
	}
	
	private var ageView : some View {
		VStack(spacing: 20) {
			Spacer()
			Text("whats your age?")
				.font(.largeTitle)
				.fontWeight(.semibold)
				.foregroundColor(.white)
			
			Text("\(String(format: "%.0f", $age as! CVarArg))")
				.font(.largeTitle)
				.fontWeight(.semibold)
				.foregroundColor(.white)
			
			Slider(value: $age, in: 18...100, step: 1)
				.accentColor(.white)
			Spacer()
			Spacer()
			
		}
		.padding(30)
		
	}
	
	
	private var genderView : some View {
		VStack (spacing: 30){
			Spacer()
			Text("enter your gender")
				.font(.largeTitle)
				.fontWeight(.semibold)
				.foregroundColor(.white)
			
			
			Picker(selection: $gender,  label:
					Text(gender.count > 1 ? gender : "gender selection")
				.font(.headline)
				.foregroundColor(.purple)
				.frame(height: 55)
				.background(Color.white)
				.foregroundColor(.white)
				.cornerRadius(10)
				  ,
				  content: {
				Text("male").tag("male")
				Text("female").tag("female")
				Text("non_binary").tag("non_binary")
				
			})
			.pickerStyle(MenuPickerStyle())
			Spacer()
			Spacer()
		}
		
	}
}

	// componenent logic
extension UserLogins {
	
	func handleBottomBtn() {
		
		switch viewSequence {
				
			case 1: guard email.count >= 3  else {
				alertTitle = "re-enter email";
				showAlert.toggle()
				return

			}
			case 2: guard password.count >= 3 else {
				alertTitle = "re-enter password";
				showAlert.toggle()
				return

			}
			case 3: guard gender.count > 1 else {
				alertTitle = "invalid age"
				showAlert.toggle()
				return
			}
			default:
				break
		}
		
		if viewSequence == 4 {
				//// CODE TO SIGN IN TO APP
			ProfileView()
				
		} else {
			withAnimation(.spring()) {
				viewSequence = 1
			}
		}
	}
}

extension UserLogins {
	
	func handleSignInData() {
		currentEmail = email
		currentPass = password
		currentAge = Int(age)
		
		withAnimation(.spring()) {
			isSignedIn = true
		}
	}
	
	
}
