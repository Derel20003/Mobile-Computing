//
//  CompassViewController.swift
//  ARExample
//
//  Created by Dominik Auinger on 28.03.22.
//

import UIKit
import CoreLocation

class CompassViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var compassLabel: UILabel!
    @IBOutlet weak var compassRoseImageView: UIImageView!
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set LocationManager and customize it
        locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.headingAvailable()) {
            self.locationManager.startUpdatingHeading()
            self.locationManager.desiredAccuracy=kCLLocationAccuracyBest
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let dir = (self.locationManager.heading?.magneticHeading.rounded())! as Double;
        compassLabel.text = "\(Int(dir))°"
        compassRoseImageView.transform = CGAffineTransform(rotationAngle: CGFloat((360-dir)*Double.pi/180))
    }

}
