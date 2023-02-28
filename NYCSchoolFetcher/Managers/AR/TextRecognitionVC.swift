
	//
	//  ViewController.swift
	//  betterImage2Text
	//
	//  Created by a-robota on 5/3/22.
	//

import UIKit
import Vision

	// vision will segement the image and return obvservations as multiple objcts.

class TextRecogniztionViewController: UIViewController {
	
	private let label: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.textAlignment = .center
		label.backgroundColor = .blue
		label.text = "..."
		return label
	}()
	
	private let imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.image = UIImage(named: "image01")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(label)
		view.addSubview(imageView)
		recognizeText(image: imageView.image)
	}
	
		// [calls the views ^]
	override func viewDidLayoutSubviews () {
		super.viewDidLayoutSubviews()
		imageView.frame = CGRect(x: 20, y: view.safeAreaInsets.top, width: view.frame.size.width - 40, height: view.frame.size.height-40)
		
		label.frame = CGRect (x: 20,
						  y: view.frame.size.width + view.safeAreaInsets.top,
						  width: 400,
						  height: 200
		)
	}
	
	
		// MARK: Handler.. Request.. process request
	
	private func recognizeText(image: UIImage?)
	{
		guard let cgImage = (image?.cgImage) else {
			fatalError("trying to find bug")
		}
		print("[+] cgImage created \(cgImage)")
		
		
			// MARK: Handler
		let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
		print("[+] text handler created \(handler)")
		
			//MARK: Request
		let request = VNRecognizeTextRequest { [weak self] request, error in
			
			if let error = error {
				print("Failed to capture face", error)
				return
			}
			
			let reqStr =
	"""
	XXXXXXXXXXXXXXXXXXXX  [Request] XXXXXXXXXXXXXXXXXXXX
	\(String(describing: request.results))
	XXXXXXXXXXXXXXXXXXXX  [Request] XXXXXXXXXXXXXXXXXXXX
	"""
			print(reqStr)
			
			
			
			guard let observations = request.results as? [VNRecognizedTextObservation], error == nil
			else { return }
			
			print("[+] text handler observations Created \(handler)")
			
				// To flatten array for observations-- makes things easiers
			let text = observations.compactMap ({
				$0.topCandidates(1).first?.string
			}).joined(separator: ", ")
			
			print("[+] Calculating topCandidates \(request)")
			DispatchQueue.main.async {
				self?.label.text = text
			}
		}
		
			// [request CB]
		DispatchQueue.global(qos: .background).async {
			do {
				try handler.perform([request])
			} catch {
				print("[-] Error Caught in Text-Handler")
				print(error)
				self.label.text = "\(error)"
			}
		}
	}
}



