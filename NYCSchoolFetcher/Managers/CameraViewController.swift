
import Foundation
import AVFoundation
import SwiftUI

struct CameraView: UIViewControllerRepresentable {
	typealias UIViewControllerType = UIViewController
		// take the camera out of main view
		//let cameraService: CameraService
	let cameraService =  CameraService()
	let didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> () // for use in the coordinator, to check finshed or not
	
	
	func makeUIViewController(context: Context) -> UIViewController {
		
		cameraService.start(delegate: context.coordinator) { err in
			if let err = err { didFinishProcessingPhoto(.failure(err))
				print(err as Any)
				return
			}
			
		}
		
		let viewController = UIViewController()
		viewController.view.backgroundColor = .black
		viewController.view.layer.addSublayer(cameraService.previewLayer)
		cameraService.previewLayer.frame = viewController.view.bounds
		return viewController
	}
	func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
		print("Updating Main UI with Photo. ")
	}
	
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self, didFinishProcessingPhoto: didFinishProcessingPhoto)
	}
	
	
	
	class Coordinator: NSObject, AVCapturePhotoCaptureDelegate {
		let parent: CameraView
		private var didFinishProcessingPhoto: (Result<AVCapturePhoto, Error>) -> ()
		
		
		init(_ parent: CameraView, didFinishProcessingPhoto: @escaping (Result<AVCapturePhoto, Error>) -> ()) {
			self.parent = parent
			self.didFinishProcessingPhoto = didFinishProcessingPhoto
			
		}
		
		
		func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcssingPhoto photo: AVCapturePhoto, error: Error?) {
			if let error = error {
				didFinishProcessingPhoto(.failure(error))
				return
			}
			didFinishProcessingPhoto(.success(photo))
		}
	}
}

