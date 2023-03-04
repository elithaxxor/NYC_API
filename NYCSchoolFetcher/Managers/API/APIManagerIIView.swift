//
//  APIManagerIIView.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 3/1/23.
//

import SwiftUI

class APIManagerII {
	
	let url = URL(string: "http://google.com")
	
	func fetchData() {
		URLSession.shared.dataTaskPublisher(for: url!)
		

	}
}
struct APIManagerIIView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct APIManagerIIView_Previews: PreviewProvider {
    static var previews: some View {
        APIManagerIIView()
    }
}
