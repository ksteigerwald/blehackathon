//
//  State.swift
//  blehackathon
//
//  Created by KRIS STEIGERWALD on 2/1/17.
//  Copyright © 2017 Velaru. All rights reserved.
//

import UIKit
import CoreLocation

class State {
    static let shared = State()
    var region:CLBeaconRegion?
    var critterCalled:Bool = false
    let colors = UIColor.Store()
    
}

let state = State.shared
let myEvents = Notification.Name("myEvts")

extension UIColor {
    struct Store {
        var blueHighlight: UIColor {
            return UIColor(red:100/255, green:210/255 ,blue:233/255 , alpha:1.0)
        }
        var baseBlue: UIColor {
            return UIColor(red:165/255, green:219/255 ,blue:220/255 , alpha:1.0)
        }
        var tanner: UIColor {
            return UIColor(red:224/255, green:228/255 ,blue:203/255 , alpha:1.0)
        }
        var lightOrg: UIColor {
            return UIColor(red:245/255, green:134/255 ,blue:30/255 , alpha:1.0)
        }
        var org: UIColor {
            return UIColor(red:253/255, green:105/255 ,blue:0/255 , alpha:1.0)
        }
        var greenis: UIColor {
            return UIColor(red:186/255, green:253/255 ,blue:0/255 , alpha:1.0)
        }

    }
    
}

extension UIView {
    // Name this function in a way that makes sense to you...
    // slideFromLeft, slideRight, slideLeftToRight, etc. are great alternative names
    func slideInFromLeft(duration: TimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        // Create a CATransition animation
        let slideInFromLeftTransition = CATransition()
        
        // Set its callback delegate to the completionDelegate that was provided (if any)
        if let delegate: AnyObject = completionDelegate {
            //slideInFromLeftTransition.delegate = delegate
        }
        
        // Customize the animation's properties
        slideInFromLeftTransition.type = CATransitionType.push
        slideInFromLeftTransition.subtype = CATransitionSubtype.fromLeft
        slideInFromLeftTransition.duration = duration
        slideInFromLeftTransition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        slideInFromLeftTransition.fillMode = CAMediaTimingFillMode.removed
        
        // Add the animation to the View's layer
        self.layer.add(slideInFromLeftTransition, forKey: "slideInFromLeftTransition")
    }
}


