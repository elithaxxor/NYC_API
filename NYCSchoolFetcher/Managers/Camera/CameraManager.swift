	//
	//  CameraManager.swift
	//  NYCSchoolFetcher
	//
	//  Created by a-robot on 2/26/23.
	//

import Foundation
import UIKit
import AVFoundation

class CameraService {
	
	var session: AVCaptureSession?
	var delegate: AVCapturePhotoCaptureDelegate?
	
	let output = AVCapturePhotoOutput()
	let previewLayer =  AVCaptureVideoPreviewLayer()
	
	func start(delegate: AVCapturePhotoCaptureDelegate, completion: @escaping (Error?) -> ()) {
		print("starting camera capture")
		self.delegate = delegate
	}
	
		/// [Camera Authorization], check Permissions.
	private func checkPermissions(completion: @escaping (Error?) ->()) {
		
		switch AVCaptureDevice.authorizationStatus(for: .video) {
			case .notDetermined:
				print("[!] AV Cannot Be Found")
				
				AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
					guard granted else { return }
					DispatchQueue.main.async {
						self?.setupCamera(completion: completion)
					}
					print("[+] System changed AV Permissions [granted] \(granted)")
				}
				
				
			case .authorized:
				print("[+] AV Authorized")
				setupCamera(completion: completion)
				
			case .restricted:
				print("[!] AV Restricted")
				break
				
			case .denied:
				print("[!] AV Denied")
				break
				
				
			@unknown default:
				break
		}
	}
	
	
		/// [setup camera sessions] --> sesssion/device, input/output, previewLayer
	func setupCamera(completion: @escaping (Error?) -> ()) {
		let session = AVCaptureSession()
		if let device = AVCaptureDevice.default(for: .video) {
			
			do { // [Camera Input]
				let input = try AVCaptureDeviceInput(device: device)
				if session.canAddInput(input) {
					session.addInput(input)
				} // [camera output]
				if session.canAddOutput(output) {
					session.addOutput(output)
				}
					// [(pre)-views]
				previewLayer.videoGravity = .resizeAspectFill
				previewLayer.session = session
				session.startRunning()
				self.session = session
				
			} catch {
				completion(error)
				
			}
		}
	}
	
		/// [invoke delegate for photo capture]
	func capturePhoto(with settings: AVCapturePhotoSettings = AVCapturePhotoSettings()) {
		output.capturePhoto(with: settings, delegate: delegate!)
	}
}
