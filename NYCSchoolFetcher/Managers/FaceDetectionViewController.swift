

import UIKit
import Vision


class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		guard let image = UIImage(named: "Image") else { return }
		let imageView = UIImageView(image: image)
		
		
			//[Frame]
		imageView.contentMode = .scaleAspectFit
		let scaledHeight = view.frame.width / image.size.width * image.size.height // to scale the height
		imageView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: scaledHeight)
		imageView.backgroundColor = .black
		
		view.addSubview(imageView)
		
		
			// [Request for facial detection]
			// VNDetectFaceRectanglesRequestRevision3
		
		let request = VNDetectFaceRectanglesRequest { (request, err) in
			if let err = err {
				print("Failed to capture face", err)
				return
			}
			print("[+] Facial Request Completed \(request) \(Date())")
			
				//.. loop through rsults, each response corrosponds to a new face
			request.results?.forEach({ (response) in
				print("[+] response recvd \(response)")
				
				guard let faceObservation = response as? VNFaceObservation else { return }
					// guard let faceLandmark = response as? VNFaceLandmarks2D else { return }
				
				let x = self.view.frame.height * faceObservation.boundingBox.origin.x
				let w = self.view.frame.width * faceObservation.boundingBox.width
				let h = scaledHeight * faceObservation.boundingBox.height
				let y = scaledHeight * (1 - faceObservation.boundingBox.minY) - h
				
				let redView = UIView()
				redView.backgroundColor = .red
				redView.frame = CGRect(x:x, y: 0, width: w, height: h)
				self.view.addSubview(redView)
				
				print("[!] Face Positions")
				print("[x: \(x) y: \(y) width: \(w) height: \(h)")
				
				
					//print("[first capture ID] ->  \(faceObservation.identifier)")
				print("[request.results] \(String(describing: request.results))")
				print("[capture first observation] \(faceObservation)")
				print("[capture first observation]--> DESCRIPTION  \(faceObservation.description)")
				print("[capture first observation]--> BOUNDING BOX  \(faceObservation.boundingBox)") // SHAPE OF FACE [BOX]--> start at lower left
				
				print("XXXXXXXXXX")
				print("[capture accuracy results] \(faceObservation.confidence)")
				
					// print("[first capture ID] ->  \(faceLandmark.identifier)")
				print("[request.results] \(String(describing: request.results))")
					//   print("[capture first observation] \(faceLandmark)")
					//  print("[capture first observation]--> DESCRIPTION  \(faceLandmark.description)")
				print("XXXXXXXXXX")
					// print("[capture accuracy results] \(faceLandmark.confidence)")
				
			})
			
				// for objects other than faces.
			guard let results = request.results as? [VNClassificationObservation] else { return }
			guard let firstObservation = results.first else { return }
			print("[first capture ID] ->  \(firstObservation.identifier)")
			print("[request.results] \(String(describing: request.results))")
			print("[capture first observation] \(firstObservation)")
			print("[capture first observation]--> DESCRIPTION  \(firstObservation.description)")
			print("XXXXXXXXXX")
			print("[capture accuracy results] \(firstObservation.confidence)")
			
		}
		
		
		guard let cgImage = image.cgImage else { return }
			// [start cgiimage convert / handle request]
		DispatchQueue.global(qos: .background).async {
			let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
			do {
				try handler.perform([request])
				print("[+] [Performing Request] \(request) ")
			} catch let err {
				print("[!] [handler error] \(err)")
			}
			
		}
	}
}

