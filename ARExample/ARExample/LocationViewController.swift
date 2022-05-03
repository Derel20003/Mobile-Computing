//
//  LocationViewController.swift
//  ARExample
//
//  Created by Dominik Auinger on 24.04.22.
//

import UIKit
import CoreLocation

class LocationViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var longitudeField: UILabel!
    @IBOutlet weak var latitudeField: UILabel!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.headingAvailable()) {
            self.locationManager.startUpdatingLocation()
            self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations newLocations: [CLLocation]) {
        guard let location: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        longitudeField.text = "\(round(Double(location.longitude) * 100000) / 100000)"
        latitudeField.text = "\(round(Double(location.latitude) * 100000) / 100000)"
    }

}
