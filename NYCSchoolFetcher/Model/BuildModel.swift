//
//  BuildModel.swift
//  ImageFetcher
//
//  Created by a-robot on 2/25/23.
//

import SwiftUI


struct customModel : Identifiable, Hashable {
	
	// to validate Identifiable
	var id = UUID().uuidString

	
	let title: String
	
	// for use if loop requires hashable
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(title)
	}
	
}
struct BuildModel: View {
	
	// inits the model
	let data: [customModel] = [
		customModel(title: "one"),
		customModel(title: "two"),
		customModel(title: "three"),
		customModel(title: "four")

	]
    var body: some View {
	    ScrollView {
		    VStack(spacing: 20) {
			    ForEach(data) { item in
				    Text(item.id)
					    .font(.headline)
			    }
		    }
	    }
    }
}

struct BuildModel_Previews: PreviewProvider {
    static var previews: some View {
        BuildModel()
    }
}
