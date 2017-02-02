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
    
    var region:CLBeaconRegion? = nil
    var regionTwo:CLBeaconRegion? = nil
    var running:Bool = true
    var critterView:FoundCritter?
    
    
    @IBAction func btnStop(_ sender: Any) {
        
        self.callCritter()
    }
    
    @IBOutlet weak var magblip: UIView!
    @IBOutlet weak var radar: CCMRadarView!
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reinit), name: myEvents, object: nil)
    }
    
    
    func callCritter(_ img: String = "lion") -> Void {
        guard !state.critterCalled else {
            return
        }
        
        let view = FoundCritter(img)
        view.pic = img
        
        self.view.addSubview(view)
    }
    func reinit(_ notification: Notification) -> Void {
        
        radar.startAnimation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("----------- appaear --------------")
        self.magblip.layer.cornerRadius = self.magblip.frame.width / 2
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    func rangeBeacons() {
        
        let uuid = UUID(uuidString: "E2C56DB5-DFFB-48D2-B060-D0F5A71096E0")
        let major:CLBeaconMajorValue = 1
        let minor:CLBeaconMinorValue = 47991
        let myid = "my.real.beacon"
        region = CLBeaconRegion(proximityUUID: uuid!, major: CLBeaconMajorValue(major), minor: CLBeaconMinorValue(minor), identifier: myid)
        
        locationManager.startRangingBeacons(in: region!)
        
        
        let uuidTwo = UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")
        let majorTwo:CLBeaconMajorValue = 0
        let minorTwo:CLBeaconMinorValue = 0
        let myidTwo = "my.virtual.beacon"
        regionTwo = CLBeaconRegion(proximityUUID: uuidTwo!, major: majorTwo, minor: minorTwo, identifier: myidTwo)
        
        self.radar.startAnimation()
        
        locationManager.startRangingBeacons(in: regionTwo!)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            // user has authorized the application -range the beacons
            rangeBeacons()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        guard self.running else { return }
        guard let discoveredBeacon = beacons.first?.proximity else {
            print("couldn't find beacon")
            return
        }
        let img = ["E2C56DB5-DFFB-48D2-B060-D0F5A71096E0":"panda","B9407F30-F5F8-466E-AFF9-25556B57FE6D":"lion"]
        
        let key = beacons.first?.proximityUUID
        
        let sticker = img[(key?.uuidString)!]
        

        let backgroundColor:UIColor = {
            switch discoveredBeacon {
            case .immediate:
                state.region = region
                self.callCritter(sticker!)
                return UIColor.green
            case .near:
                state.region = region
                self.callCritter(sticker!)
                return UIColor.orange
            case .far:
                return UIColor.yellow
            case .unknown: return UIColor.red
            }
        }()
        self.magblip.layer.backgroundColor = backgroundColor.cgColor
        //view.backgroundColor = backgroundColor
        
    }
    
}
