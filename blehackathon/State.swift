//
//  State.swift
//  blehackathon
//
//  Created by KRIS STEIGERWALD on 2/1/17.
//  Copyright © 2017 Velaru. All rights reserved.
//

import Foundation
import CoreLocation

class State {
    static let shared = State()
    
    var region:CLBeaconRegion?
    
}

let state = State.shared
let myEvents = Notification.Name("myEvts")

