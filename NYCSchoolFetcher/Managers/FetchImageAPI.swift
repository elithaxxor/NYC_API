//
//  FetchImageAPI.swift
//  NYCSchoolFetcher
//
//  Created by a-robot on 2/25/23.
//

import SwiftUI
import Combine


class imageAPIManager {
	var url = URL(string: "https://picsum.photos/photos/300")
	static let shared = imageAPIManager()
	
	
	
	func fetchImage() async throws -> UIImage {
		do {
			let (data, response) = try await URLSession.shared.data(from : url!, delegate: nil)
			print("[!] Response recvd \(response)")
			print("[+] Data received \(String(describing: data.first))")
			
			if let image = UIImage(data: data) {
				print("[+] Image recieved")
				return image
			} else {
				print("[-] throwing url error... \(URLError(.badURL))")
				throw URLError(.badURL)
			}
			
		} catch {
			print("[-] general error in fetching error  \(error.localizedDescription)")
			throw error
		}
	}
}
