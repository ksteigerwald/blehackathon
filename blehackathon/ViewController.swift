//
//  ViewController.swift
//  HackAthonBle
//
//  Created by Steigerwald, Kris S. (CONT) on 2/1/17.
//  Copyright © 2017 CapitlaOne. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func rangeBeacons() {
        
        let uuid = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        let major:CLBeaconMajorValue = 1
        let minor:CLBeaconMinorValue = 47991
        let myid = "my.real.beacon"
        let region = CLBeaconRegion(proximityUUID: uuid!, major: CLBeaconMajorValue(major), minor: CLBeaconMinorValue(minor), identifier: myid)
        
        locationManager.startRangingBeacons(in: region)
        
        
        let uuidTwo = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
        let majorTwo:CLBeaconMajorValue = 0
        let minorTwo:CLBeaconMinorValue = 0
        let myidTwo = "my.virtual.beacon"
        let regionTwo = CLBeaconRegion(proximityUUID: uuidTwo!, major: majorTwo, minor: minorTwo, identifier: myidTwo)
        
        locationManager.startRangingBeacons(in: regionTwo)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // user has authorized the application -range the beacons
            rangeBeacons()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        print(beacons)
        guard let discoveredBeacon = beacons.first?.proximity else {
            print("couldn't find beacon")
            return
        }
        
        let backgroundColor:UIColor = {
            switch discoveredBeacon {
            case .immediate: return UIColor.green
            case .near: return UIColor.orange
            case .far: return UIColor.red
            case .unknown: return UIColor.black
            }
        }()
        
        view.backgroundColor = backgroundColor
        
    }
    
}
