//
//  DiscoverViewController.swift
//  blehackathon
//
//  Created by KRIS STEIGERWALD on 2/1/17.
//  Copyright © 2017 Velaru. All rights reserved.
//

import UIKit

class DiscoverViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.post(name: myEvents, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    

    
   }
