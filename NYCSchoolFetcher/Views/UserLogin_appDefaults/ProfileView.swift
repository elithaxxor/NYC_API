//
//  ProfileView.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 3/4/23.
//

import SwiftUI

struct ProfileView: View {
	
		// storage--> received from UserLogin view
		@AppStorage("signed_in") var isSignedIn : Bool = false
		@AppStorage("age") var currentAge: Int?
		@AppStorage("gender") var currentGender : String?
		@AppStorage("email") var currentEmail : String?
		@AppStorage("pass") var currentPass : String?

		
	
	
    var body: some View {
	    VStack (spacing: 30) {
		    Image(systemName: "person.circle.fill")
			    .resizable()
			    .scaledToFill()
			    .frame(width: 150, height: 150)
		    
		    Text(currentEmail ?? "your email here")
		    Text("email \(currentEmail ?? "unknown")")
		    Text("gender \(currentGender ?? "unknown")")
		    Text("age \(currentAge ?? 0)")
			    
			    
		    Text("sign out")
			    .foregroundColor(.white)
			    .font(.headline)
			    .frame(height: 55)
			    .frame(maxWidth: .infinity)
			    .cornerRadius(10)
			    .onTapGesture {
				    signOut()
			    }


	    }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

extension ProfileView {
	
	func signOut() {
		withAnimation(.spring()) {
			isSignedIn = false

		}
		currentAge = nil
		currentGender = nil
		currentEmail = nil
		currentPass = nil
	}
}
