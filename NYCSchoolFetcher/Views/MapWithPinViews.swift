//	//
//	//  MapWithPinViews.swift
//	//  NYCSchoolFetcher
//	//
//	//  Created by a-robot on 2/26/23.
//	//
//
//
//
//
//import LocalAuthentication
//import LocalAuthenticationEmbeddedUI
//
//import UIKit
//import MapKit
//import Foundation
//
//
//
//internal class HomeViewController: UIViewController {
//	
//	@IBOutlet weak var statusLabel : UILabel!
//	@IBOutlet weak var latitudeLabel : UILabel!
//	@IBOutlet weak var longitudeLabel : UILabel!
//	@IBOutlet weak var addressLabel : UILabel!
//	@IBOutlet weak var findLocationButton : UIButton!
//	
//	
//	fileprivate var LM = LocationManager()
//	fileprivate var NM = LocationNetworkManager()
//	
//	fileprivate let locationManager = CLLocationManager()
//	
//	
//	
//	private func updateUI() {
//		if let location = LM.location { //
//			
//		} else {
//			statusLabel.text = "tap me"
//			latitudeLabel.text = "-"
//			longitudeLabel.text = "-"
//			addressLabel.text = "-  "
//		}
//	}
//	
//	
//	let mapView : MKMapView = {
//		let map = MKMapView()
//		map.overrideUserInterfaceStyle = .dark
//		return map
//	}()
//	
//	
//	
//	override func viewDidLoad() {
//		super.viewDidLoad()
//		mapConstraints()
//		mapView.delegate = self
//		view.addSubview(button)
//		
//			// parses json after receivng data
//		if let routeJson = NM.getJson() {
//			NM.parseJson(jsonData: routeJson)
//		}
//		addPins()
//	}
//	
//	fileprivate func addPins() {
//		if NM.routeCoordinates.count != 0 {
//			let startPin = MKPointAnnotation() // drops the first pin
//			startPin.title = "start"
//			startPin.coordinate = CLLocationCoordinate2D(
//				latitude: NM.routeCoordinates[0].coordinate.latitude, longitude: NM.routeCoordinates[0].coordinate.longitude
//			)
//			mapView.addAnnotation(startPin)
//			let endPin = MKPointAnnotation() // 2nd pin
//			endPin.title = "end"
//			endPin.coordinate = CLLocationCoordinate2D(
//				latitude: NM.routeCoordinates.last!.coordinate.latitude,
//				longitude:  NM.routeCoordinates.last!.coordinate.longitude
//			)
//			mapView.addAnnotation(endPin)
//		}
//	}
//	
//	func drawRoute(routeData: [CLLocation]) {
//		if routeData.count == 0 {
//			print("no coordinates ")
//			return
//		}
//		let coordinates = routeData.map { location -> CLLocationCoordinate2D in
//			return location.coordinate
//		}
//		
//		
//			// setsup UI Overlay (map)
//		DispatchQueue.main.async { [self] in
//			NM.routeOverlay = MKPolyline(coordinates: coordinates, count: coordinates.count)
//			self.mapView.addOverlay(NM.routeOverlay!, level: .aboveRoads)
//			
//			let customEdgePadding : UIEdgeInsets = UIEdgeInsets(
//				top: 50,
//				left: 50,
//				bottom: 50,
//				right: 50
//			)
//			self.mapView.setVisibleMapRect(NM.routeOverlay!.boundingMapRect, animated: true)
//		}
//	}
//	
//	
//	
//	fileprivate func mapConstraints() {
//		mapView.translatesAutoresizingMaskIntoConstraints = false
//		mapView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//		mapView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
//		mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//		mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//		view.addSubview(mapView)
//		
//	}
//	
//	
//	
//	fileprivate let button : UIButton = {
//		let b = UIButton()
//		
//		b.translatesAutoresizingMaskIntoConstraints = false
//		b.titleLabel?.textAlignment = .center
//		b.widthAnchor.constraint(equalToConstant: 10)
//		b.heightAnchor.constraint(equalToConstant: 200)
//			//        b.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
//			//        b.centerXAnchor.constraint(equalTo: view.centerXAnchor)
//			//
//		
//		b.translatesAutoresizingMaskIntoConstraints = false
//		b.titleLabel?.textAlignment = .center
//		b.setTitle("authorize", for: .normal)
//		b.backgroundColor = .systemGreen
//		
//		b.addTarget(HomeViewController.self,
//				  action: #selector(didTapButton),
//				  for: .touchUpInside)
//		
//		return b
//		
//	}()
//	
//	@objc func didTapButton() {
//		var error : NSError? = nil
//		let context = LAContext()
//		if context.canEvaluatePolicy(
//			.deviceOwnerAuthenticationWithBiometrics,
//			error: &error) {
//			
//			let reason = "open sesame"
//			context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, error in
//				DispatchQueue.main.async {
//					guard  success, error == nil
//					else {  // fail
//						let alert = UIAlertController(
//							title: "guess again..",
//							message: "try bruteforce ;)",
//							preferredStyle: .alert)
//						alert.addAction(UIAlertAction(title: "leave",
//												style: .cancel,
//												handler: nil))
//						self?.present(alert, animated: true)
//						return
//						
//					}
//					print("success")
//					let vc = UIViewController()
//					vc.title = "enter young padawon"
//					vc.view.backgroundColor = .systemBlue
//					self?.present(UINavigationController(rootViewController: vc),
//							    animated: true,
//							    completion: nil)
//					
//				}
//			}
//		}
//	}
//	
//	
//	override func didReceiveMemoryWarning() {
//		super .didReceiveMemoryWarning()
//	}
//}
//
//extension HomeViewController : MKMapViewDelegate {
//	
//	func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
//		let renderer = MKGradientPolylineRenderer(overlay: overlay)
//		
//			//		renderer.setColors([UIColor(red: 0.02, green: 0.091, blue: 0.05, alpha: 1.0),
//			//						UIColor(red: 1.0, green: 0.48, blue: 0.0, alpha: 1.0),
//			//						UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1.0),
//			//
//			//					    ], locations: <#[CGFloat]#>),locations: [])
//			//
//		renderer.lineCap = .round
//		renderer.lineWidth = 3.0
//		
//		
//	}
//}
//	
//	
//	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//		if annotation is MKUserLocation { return nil }
//		
//		var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "String")
//		if annotationView == nil { annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "string")} else {
//			annotationView?.annotation = annotation
//		}
//		
//		switch annotation.title {
//			case "end "
//				: annotationView?.image = UIImage(named: "pinEnd")
//			case "start" :
//				annotationView?.image = UIImage(named: "pinStart")
//			default:
//				break
//		}
//		return annotationView
//		
//	}
//}
//
//	// NOTE: Location manager extension for home-view-controller. Use 'LM' to access class.
//extension HomeViewController : CLLocationManagerDelegate {
//	
//	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//		print("locatino manager error \(error)")
//		
//		if (error as NSError).code == CLError.locationUnknown.rawValue { return }
//		
//		LM.lastLocationError = error
//		LM.stopLocationManager()
//		updateUI()
//	}
//	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//		print("did update location \(manager.location)")
//	}
//}
//
//
//
//
//	// @IBOutlet weak var map : MKMapView!
//
//	//    fileprivate let mapView : MKMapView = {
//	//        let map = MKMapView()
//	//        map.overrideUserInterfaceStyle = .dark
//	//
//	//
//	//        return map
//	//    }()
//	//
//	//
